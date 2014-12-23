//
//  LambertSwift.swift
//  LambertSwift
//
//  Created by HEINRICH Yannick on 23/12/2014.
//  Copyright (c) 2014 yageek. All rights reserved.
//

import CoreLocation
import Darwin


public enum LambertZone :Int{
    case LambertI = 0
    case LambertII
    case LambertIII
    case LambertIV
    case LambertII_E
    case Lambert93
}



let E_CLARK_IGN: Double  = 0.08248325676
let E_WGS84: Double =  0.08181919106
let A_CLARK_IGN:Double = 6378249.2
let A_WGS84:Double = 6378137.0

let LON_MERID_PARIS: Double = 0
let LON_MERID_GREENWICH: Double = 0.04079234433
let LON_MERID_IERS: Double = (3*M_PI/180)

internal let lambert_n : [Double] = [0.7604059656, 0.7289686274, 0.6959127966, 0.6712679322, 0.7289686274, 0.7256077650]
internal let lambert_c: [Double] = [11603796.98, 11745793.39, 11947992.52, 12136281.99, 11745793.39, 11754255.426]
internal let lambert_xs: [Double] = [600000.0, 600000.0, 600000.0, 234.358, 600000.0, 700000.0]
internal let lambert_ys: [Double] = [5657616.674, 6199695.768, 6791905.085, 7239161.542, 8199695.768, 12655612.050]

internal struct Point{
    var x:Double
    var y:Double
    var z:Double
}

internal let EPS = 10e6
internal func latitudeISOFromLatitude(lat: Double, e: Double) -> Double {
    return log(tan(M_PI_4+lat/2)*pow((1-e*sin(lat))/(1+e*sin(lat)),e/2));
}


internal func latitudeFromLatitudeISO(lat_iso: Double, e: Double, eps: Double) -> Double {
    var phi_0: Double = 2*atan(exp(lat_iso)) - M_PI_2
    var phi_i: Double =  2*atan(pow((1+e*sin(phi_0))/(1-e*sin(phi_0)),e/2.0)*exp(lat_iso)) - M_PI_2
    
    var delta: Double = 1000
    while(delta > EPS){
        phi_0 = phi_i
        phi_i =  2*atan(pow((1+e*sin(phi_0))/(1-e*sin(phi_0)),e/2.0)*exp(lat_iso)) - M_PI_2
    }
    
    return phi_i
}


internal func lamberToGeographic(org: Point, zone: LambertZone, lon_merid: Double, e: Double, eps: Double) -> Point{
    
    
    let n = lambert_n[zone.rawValue]
    let C = lambert_c[zone.rawValue]
    let x_s = lambert_xs[zone.rawValue]
    let y_s = lambert_ys[zone.rawValue]
    
    var x = org.x
    var y = org.y
    
    var x2 = (x - x_s) * (x - x_s)
    var y2 = (y - y_s) * (y - y_s)
    let R = sqrt( x2 + y2 );
    
    let gamma = atan((x-x_s)/(y_s-y))
    
    let lon = lon_merid + gamma / n
    
    var lat_iso = -1/n*log(fabs(R/C))
    
    return Point(x: lon, y: latitudeFromLatitudeISO(lat_iso, e, eps), z:0)
    
}

internal func lambertNormal(lat: Double, a: Double, e: Double) -> Double {
    return a/sqrt(1-e*e*sin(lat)*sin(lat))
}


internal func geographicToCartesian(lon: Double,lat: Double, he:Double, a: Double, e: Double) -> Point {
    
    let N = lambertNormal(lat, a, e)
    
    var pt = Point(x: 0, y: 0, z:0)
    pt.x = (N+he)*cos(lat)*cos(lon)
    
    pt.y = (N+he)*cos(lat)*sin(lon)
    
    pt.z = (N*(1-e*e)+he)*sin(lat)
    
    return pt
}

internal func cartesianToGeographic(org: Point, meridian: Double, a: Double, e: Double, eps: Double) -> Point {
    
    let x = org.x, y = org.y, z = org.z;
    
    let lon = meridian + atan(y/x)
    
    let module = sqrt(x*x + y*y)
    
    var phi_0 = atan(z/(module*(1-(a*e*e)/sqrt(x*x+y*y+z*z))));
    var phi_i = atan(z/module/(1-a*e*e*cos(phi_0)/(module * sqrt(1-e*e*sin(phi_0)*sin(phi_0)))))
    var delta: Double = fabs(phi_i - phi_0)
    while(delta > eps)
    {
        phi_0 = phi_i
        phi_i = atan(z/module/(1-a*e*e*cos(phi_0)/(module * sqrt(1-e*e*sin(phi_0)*sin(phi_0)))));
        
    }
    
    let he = module/cos(phi_i) - a/sqrt(1-e*e*sin(phi_i)*sin(phi_i))
    
    return Point(x:lon, y: phi_i, z:he)
}

internal func pointToWGS84(point: Point, zone: LambertZone) -> Point{
    
    var dest: Point
    if (.Lambert93 == zone){
        dest = lamberToGeographic(point, zone, LON_MERID_IERS, E_WGS84, EPS)
    } else {
        dest = lamberToGeographic(point, zone, LON_MERID_PARIS, E_CLARK_IGN, EPS)
        dest = geographicToCartesian(dest.x, dest.y, dest.z, A_CLARK_IGN, E_CLARK_IGN)
        
        dest.x -= 168
        dest.y -= 60
        dest.z += 320
        
        dest = cartesianToGeographic(dest, LON_MERID_GREENWICH, A_WGS84, E_WGS84, EPS)
    }
    
    return dest
}

extension CLLocation {
       public convenience init(x: Double, y: Double, inZone: LambertZone){
        
        
        var org:Point = Point(x: x, y: y, z: 0)
        var dest: Point = pointToWGS84(org, inZone)
        let f : Double = 180.0/M_PI
        dest.x *= f
        dest.y *= f
        
        self.init(latitude: dest.y, longitude: dest.x)
        
    }
}
