//
//  ViewController.swift
//  Weather
//
//  Created by Amardeep Kaur on 01/11/20.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var searchStackView: UIStackView!
    @IBOutlet weak var myTableView: UITableView!
    var blurAnimator: UIViewPropertyAnimator!
    
    lazy var homeViewModel: HomeViewModel = {
        return HomeViewModel()
    }()
    
    var cityName: String?
    var locationManager = CLLocationManager()
    
    //MARK:- Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        searchTextField.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        updateElements()
    }

    override func viewDidAppear(_ animated: Bool) {
        setUpUI()
        myTableView.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: .light)
        let visualBlurView = UIVisualEffectView(effect: blurEffect)
        visualBlurView.translatesAutoresizingMaskIntoConstraints = false
        visualBlurView.frame = myTableView.frame
        myTableView.backgroundView = visualBlurView

    }
    
    @IBAction func fetchCurrentLocation(_ sender: Any) {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    @IBAction func searchCity(_ sender: Any) {
        resignFirstResponder()
        updateElements()
    }
    
    @IBAction func didTapList(_ sender: Any) {
        print("Show list of cities")
    }
    
    //MARK: Update UI elements
    func updateElements() {
        cityLabel.text = "Mohali"
    }
    
    func setUpUI() {
        let path = UIBezierPath.init(roundedRect: bottomView.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 20.0, height: 20.0))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        bottomView.layer.mask = maskLayer
    }
    //MARK: - Blur background view
    
    fileprivate func addBlurView() {
        removeBlurView()
        let blurEffect = UIBlurEffect(style: .extraLight)
        let visualBlurView = UIVisualEffectView(effect: blurEffect)
        visualBlurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(visualBlurView, aboveSubview: view)

        NSLayoutConstraint.activate([
            visualBlurView.topAnchor.constraint(equalTo: searchStackView.bottomAnchor),
            visualBlurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            visualBlurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            visualBlurView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])

        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = weatherImage.bounds
        visualBlurView.contentView.addSubview(vibrancyEffectView)

    }
    
    fileprivate func removeBlurView() {
        for subview in view.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
    
    func saveCityName() {
        
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK:- Tableview delegate and datasource
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeViewModel.weatherList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weatherCell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as! DailyWeatherCell
        weatherCell.configure(weather: homeViewModel.weatherList[indexPath.row])
        return weatherCell
     }
}

extension HomeViewController: UITextFieldDelegate {
    //MARK: - TextField delegates
    func textFieldDidBeginEditing(_ textField: UITextField) {
        addBlurView()
        //searchTextField.text = textField.text
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchTextField.text = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        removeBlurView()
        searchTextField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchTextField.resignFirstResponder()
        removeBlurView()
    }
}

extension HomeViewController: CLLocationManagerDelegate {
    //MARK: Location Manager
    func locationPermissionManager() {
        //Ask user permission for location access
        locationManager.requestAlwaysAuthorization()
        //Ask for use in foreground
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation
        let lat = userLocation.coordinate.latitude
        print("first lat is \(lat)")
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            //convert lat to city location
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count > 0 {
                let placemark = placemarks![0]
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                print(placemark.country!)
                
                //self.labelAdd.text = "\(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!)"
                self.cityLabel.text = placemark.locality
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to load the location")
    }
}
