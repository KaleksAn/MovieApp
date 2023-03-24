//
//  HomeVC.swift
//  MovieApp
//
//  Created by Aleksandr Kan on 15/03/23.
//

import UIKit

enum Sectios: Int {
    case TrendingMovies
    case TrendingTv
    case Popular
    case Upcoming
    case TopRated
}

class HomeVC: UIViewController {
    
    private let sectionTitles = ["Популярные фильмы", "Топ TV", "Смотрят сейчас", "Скоро", "Лучшие"]
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

       // view.backgroundColor = .systemBackground
        setupViews()
        setupDelegates()
        configureNavBar()
        
       // navigationController?.pushViewController(TitlePreviewVC(), animated: true)
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds
    }
    
    private func setupViews() {
        view.addSubview(tableView)
        
        //MARK: - Setup header view for tableView
        let mainImageView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        tableView.tableHeaderView = mainImageView
    }
    
    private func setupDelegates() {
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }
    
    private func configureNavBar() {
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        navigationController?.navigationBar.tintColor = .white
        
    }
    
    
}

//MARK: - UITableViewDelegate
extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
    
}

//MARK: - UITableViewDataSource
extension HomeVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as! CustomTableViewCell
        
        cell.delegate = self
        
        switch indexPath.section {
        case Sectios.TrendingMovies.rawValue:
            NetworkManager.shared.getTrendingMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sectios.TrendingTv.rawValue:
            NetworkManager.shared.getTrandingTv { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error)
                }
            }
            
        case Sectios.Popular.rawValue:
            NetworkManager.shared.getPopular { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sectios.Upcoming.rawValue:
            NetworkManager.shared.getUpcomingMovies { result in
                switch result {
                case .success(let movies):
                    cell.configure(with: movies)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
        case Sectios.TopRated.rawValue:
            NetworkManager.shared.getTopRated { result in
                switch result {
                case .success(let movie):
                    cell.configure(with: movie)
                case .failure(let error):
                    print(error)
                }
            }
            
        default:
            return UITableViewCell()
        }
        
        
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        var configute = header.defaultContentConfiguration()
        //configute.textProperties.font = .systemFont(ofSize: 18, weight: .semibold)
        configute.textProperties.color = .white
        configute.attributedText = NSAttributedString(string: sectionTitles[section], attributes:
                                                        [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)])
        header.contentConfiguration = configute

    }
    
}


extension HomeVC: CustomTableViewCellDelegate {
    
    func customTableViewCellDidTapCell(_ cell: CustomTableViewCell, viewModel: TitlePreviewViewModel) {
        
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewVC()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
