//
//  DownloadsViewController.swift
//  Netflix Clone
//
//  Created by Ahmed Salem on 17/11/2022.
//

import UIKit

class DownloadsViewController: UIViewController {

    private var titles: [TitleItem] = [TitleItem]()
    private let Downloadedtable: UITableView = {
       let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Downloads"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.addSubview(Downloadedtable)
        Downloadedtable.delegate = self
        Downloadedtable.dataSource = self
        
        fetchLocalStorageForDownload()
        NotificationCenter.default.addObserver(forName: NSNotification.Name("Downloaded"), object: nil, queue: nil){ _ in
            self.fetchLocalStorageForDownload()
        }
        
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        fetchLocalStorageForDownload()
//    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        Downloadedtable.frame = view.bounds
    }
    
    private func fetchLocalStorageForDownload()
    {
        DataPersistenceManager.shared.fetchingTitlesFromDatabase{ [weak self] result in
            switch result{
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.Downloadedtable.reloadData()
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

extension DownloadsViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else{
            return UITableViewCell()
        }
        let titles = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: titles.original_title ?? titles.original_name ?? "Unknown Title Name", posterURL: titles.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle{
        case .delete:
            
            DataPersistenceManager.shared.deleteTitleWith(model: titles[indexPath.row]){ [weak self] result in
                switch result{
                case .success():
                    
                    print("Deleted form the database")
                case .failure(let error):
                    print(error.localizedDescription)
           
                }
                self?.titles.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
        default:
            break
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        guard let titleName = title.original_title ?? title.original_name else { return }
        
        APICaller.shared.getMovie(with: titleName){ [weak self] result in
            
            switch result
            {
            case .success(let videoElement):
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
                    
                    self?.navigationController?.pushViewController(vc, animated: true)
                    
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
