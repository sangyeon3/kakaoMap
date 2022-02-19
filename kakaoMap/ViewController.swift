//
//  ViewController.swift
//  kakaoMap
//
//  Created by  sangyeon on 2022/02/19.
//

import UIKit

class ViewController: UIViewController, MTMapViewDelegate {
    
    var mapView: MTMapView?
    var mapPoint: MTMapPoint?
    var poiItem: MTMapPOIItem?
    var circle: MTMapCircle?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapViewSetting()
    }

    private func mapViewSetting(){
        mapView = MTMapView(frame: self.view.bounds)
        if let mapView = mapView {
            mapView.delegate = self
            mapView.baseMapType = .standard
            self.view.addSubview(mapView)
            
            // 지도 센터 설정 - x, y 좌표와 줌 레벨 등
            mapView.setMapCenter(MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.5070, longitude: 126.7218)), zoomLevel: 1, animated: true)
        }
        
        //MARK: PIN 마커 추가
        mapPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.5070, longitude: 126.7218))
                              
        poiItem = MTMapPOIItem()
        poiItem?.mapPoint = mapPoint
        poiItem?.itemName = "pin"
        poiItem?.markerType = MTMapPOIItemMarkerType.redPin
        poiItem?.tag = 0
        mapView?.add(poiItem)
        
        
        //MARK: 원 그리기
        circle = MTMapCircle()
        circle?.circleCenterPoint = MTMapPoint(geoCoord: MTMapPointGeo(latitude: 37.5070, longitude: 126.7218))
        circle?.circleFillColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.3)
        circle?.circleLineColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.3)
        circle?.tag = 1
        circle?.circleRadius = 500
        //mapView?.addCircle(circle)
        //mapView?.fitArea(toShow: circle)
        
        // 현위치 트래킹
        mapView?.showCurrentLocationMarker = true
        mapView?.currentLocationTrackingMode = .onWithoutHeading
    }
    
    func mapView(_ mapView: MTMapView!, updateCurrentLocation location: MTMapPoint!, withAccuracy accuracy: MTMapLocationAccuracy) {
        let currentLocationPointGeo = location.mapPointGeo()
        print("MTMapView updateCurrentLocation (\(currentLocationPointGeo.latitude), \(currentLocationPointGeo.longitude)) accuracy (\(accuracy))")
    }
    
    func mapView(_ mapView: MTMapView!, updateDeviceHeading headingAngle: MTMapRotationAngle) {
        print("MTMapView updateDeviceHeading (\(headingAngle) degrees")
    }
    
}

