
import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var mapType: UISegmentedControl!
    var alerta: UIAlertController!
    var rota: MKRoute?
    
    var locManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locManager = CLLocationManager()
        alerta = UIAlertController(title: "Aguarde", message: "Calculando rota...", preferredStyle: UIAlertControllerStyle.Alert)
    }
    
    @IBAction func desenharLinha(sender: AnyObject) {
        
        let pontoInicial = self.map.convertPoint(CGPoint(x: 50, y: 50), toCoordinateFromView: self.map)
        let pontoFinal = self.map.convertPoint(CGPoint(x: 50, y: 150), toCoordinateFromView: self.map)
        var coordenadas = [pontoInicial, pontoFinal]
        
        let linha = MKPolyline(coordinates: &coordenadas, count: coordenadas.count)
        
        self.map.addOverlay(linha)
    }
    
    @IBAction func desenharPoligono(sender: AnyObject) {
        
        let ponto1 = self.map.convertPoint(CGPoint(x: 50, y: 50), toCoordinateFromView: self.map)
        let ponto2 = self.map.convertPoint(CGPoint(x: 50, y: 150), toCoordinateFromView: self.map)
        let ponto3 = self.map.convertPoint(CGPoint(x: 150, y: 50), toCoordinateFromView: self.map)
        var coordenadas = [ponto1, ponto2, ponto3]
        
        let triangulo = MKPolygon(coordinates: &coordenadas, count: coordenadas.count)
        
        self.map.addOverlay(triangulo)
    }
    
    @IBAction func desenharCirculo(sender: AnyObject) {
        
        let raio = self.map.region.span.latitudeDelta * 20000
        let circulo = MKCircle(centerCoordinate: self.map.centerCoordinate, radius: raio)
        self.map.addOverlay(circulo)
    }
    
    @IBAction func addPin() {
        
        let pin: MKPointAnnotation = MKPointAnnotation()
        pin.title = "Buscando informações..."
        
        let coord: CLLocationCoordinate2D = self.map.convertPoint(self.view.center, toCoordinateFromView: self.view)
        
        let geoCoder: CLGeocoder = CLGeocoder()
        
        let newLocation: CLLocation = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
        
        geoCoder.reverseGeocodeLocation(newLocation, completionHandler: { (placemarks, error) -> Void in
            
            let address: CLPlacemark = placemarks[0] as! CLPlacemark
            
            pin.title = address.thoroughfare
            
            if address.subLocality != nil && address.administrativeArea != nil{
                pin.subtitle = address.subLocality + " " + address.administrativeArea
            }
        })
        
        pin.coordinate = coord
        
        self.map.addAnnotation(pin)
        
    }
    
    @IBAction func changeMapType() {
        
        switch self.mapType.selectedSegmentIndex{
        case 0:
            self.map.mapType = MKMapType.Standard
            break
            
        case 1:
            self.map.mapType = MKMapType.Hybrid
            break
            
        case 2:
            self.map.mapType = MKMapType.Satellite
            break
            
        default:
            break
        }
    }
    
    @IBAction func findMe() {
        
        if (CLLocationManager.locationServicesEnabled()) {
            locManager.requestWhenInUseAuthorization()
            locManager.delegate = self
            locManager.startUpdatingLocation()
        }
        else {
            let alert = UIAlertController(title: "Ops!", message: "Habilite a Geolocalização do seu aparelho", preferredStyle: .Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler:nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    func calloutDetalhePressionado() {
        
        if let rotaAdicionada = self.rota{
            self.map.removeOverlay(rotaAdicionada.polyline)
        }
        
        let pinoSelecionado =  self.map.selectedAnnotations.first as! MKPointAnnotation
        
        let inicioRota = MKPlacemark(coordinate: pinoSelecionado.coordinate, addressDictionary: nil)
        let coordenadaDestino = CLLocationCoordinate2D(latitude: -23.565893, longitude: -46.650874)
        let finalRota = MKPlacemark(coordinate: coordenadaDestino, addressDictionary: nil)
        
        let requisicao = MKDirectionsRequest()
        requisicao.setSource(MKMapItem(placemark: inicioRota))
        requisicao.setDestination(MKMapItem(placemark: finalRota))
        requisicao.transportType = MKDirectionsTransportType.Automobile
        requisicao.requestsAlternateRoutes = true
        
        presentViewController(alerta, animated: true, completion: nil)
        self.map.deselectAnnotation(self.map.selectedAnnotations[0] as! MKAnnotation, animated: true)
        
        let roteador = MKDirections(request: requisicao)
        roteador.calculateDirectionsWithCompletionHandler { (resposta, erro) -> Void in
            if erro == nil{
                self.rota = resposta.routes[0] as? MKRoute
                self.dismissViewControllerAnimated(true, completion: { () -> Void in
                    self.map.addOverlay(self.rota?.polyline, level: MKOverlayLevel.AboveRoads)
                })
            }
            else{
                println("Erro ao calcular rota " + erro.description)
            }
        }
    }
}

extension ViewController: CLLocationManagerDelegate{
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        
        let locationArray = locations as NSArray
        let locationObj = locationArray.lastObject as! CLLocation
        
        let zoom: MKCoordinateSpan = MKCoordinateSpanMake(0.001, 0.001)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(locationObj.coordinate, zoom)
        
        self.map.setRegion(region, animated: true)
        
//        locManager.stopUpdatingLocation()
    }
}

extension ViewController: MKMapViewDelegate{
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        let pinView: MKAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "pin")
        
        pinView.canShowCallout = true
        pinView.image = UIImage(named: "custompin")
        let botaoDetalhes = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIButton
        botaoDetalhes.addTarget(self, action: "calloutDetalhePressionado", forControlEvents: UIControlEvents.TouchUpInside)
        pinView.rightCalloutAccessoryView = botaoDetalhes
        
        return pinView
    }
    
    func mapView(mapView: MKMapView!, rendererForOverlay overlay: MKOverlay!) -> MKOverlayRenderer! {
        
        if overlay is MKPolyline{
            let linhaRender = MKPolylineRenderer(overlay: overlay)
            linhaRender.strokeColor = UIColor.redColor()
            linhaRender.lineWidth = 2.0
            return linhaRender
        }
        else if overlay is MKPolygon{
            let poligonoRender = MKPolygonRenderer(overlay: overlay)
            poligonoRender.strokeColor = UIColor.redColor()
            poligonoRender.lineWidth = 2.0
            poligonoRender.fillColor = UIColor.blueColor()
            poligonoRender.alpha = 0.3
            return poligonoRender
        }
        else if overlay is MKCircle{
            let circuloRender = MKCircleRenderer(overlay: overlay)
            circuloRender.strokeColor = UIColor.redColor()
            circuloRender.lineWidth = 2.0
            circuloRender.fillColor = UIColor.greenColor()
            circuloRender.alpha = 0.3
            return circuloRender
        }
        
        return nil
    }
}




