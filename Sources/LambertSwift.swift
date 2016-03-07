//
//  LambertSwift.swift
//  LambertSwift
//
//  Created by HEINRICH Yannick on 23/12/2014.
//  Copyright (c) 2014 yageek. All rights reserved.
//

import CoreLocation
import Darwin



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
        delta = fabs(phi_i - phi_0)
    }
    
    return phi_i
}


internal func lamberToGeographic(org: Point, zone: LambertZone, lon_merid: Double, e: Double, eps: Double) -> Point{
    
    
    let n = zone.n
    let C = zone.c
    let x_s = zone.xs
    let y_s = zone.ys
    
    let x = org.x
    let y = org.y
    
    let x2 = (x - x_s) * (x - x_s)
    let y2 = (y - y_s) * (y - y_s)
    let R = sqrt( x2 + y2 );
    
    let gamma = atan((x-x_s)/(y_s-y))
    
    let lon = lon_merid + gamma / n
    
    let lat_iso = -1/n*log(fabs(R/C))
    
    return Point(x: lon, y: latitudeFromLatitudeISO(lat_iso, e: e, eps: eps), z:0)
    
}

internal func lambertNormal(lat: Double, a: Double, e: Double) -> Double {
    return a/sqrt(1-e*e*sin(lat)*sin(lat))
}


internal func geographicToCartesian(lon: Double,lat: Double, he:Double, a: Double, e: Double) -> Point {
    
    let N = lambertNormal(lat, a: a, e: e)
    
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
    let tanphi_i = z/module/(1-a*e*e*cos(phi_0)/(module * sqrt(1-e*e*sin(phi_0)*sin(phi_0))))
    var phi_i = atan(tanphi_i)
    var delta: Double = fabs(phi_i - phi_0)
    while(delta > eps)
    {
        phi_0 = phi_i
        phi_i = atan(z/module/(1-a*e*e*cos(phi_0)/(module * sqrt(1-e*e*sin(phi_0)*sin(phi_0)))));
        delta = fabs(phi_i - phi_0)
    }
    
    let he = module/cos(phi_i) - a/sqrt(1-e*e*sin(phi_i)*sin(phi_i))
    
    return Point(x:lon, y: phi_i, z:he)
}

internal func pointToWGS84(point: Point, zone: LambertZone) -> Point{
    
    var dest: Point
    if (.L93 == zone){
        dest = lamberToGeographic(point, zone: zone, lon_merid: LON_MERID_IERS, e: E_WGS84, eps: EPS)
    } else {
        dest = lamberToGeographic(point, zone: zone, lon_merid: LON_MERID_PARIS, e: E_CLARK_IGN, eps: EPS)
        dest = geographicToCartesian(dest.x, lat: dest.y, he: dest.z, a: A_CLARK_IGN, e: E_CLARK_IGN)
        
        dest.x -= 168
        dest.y -= 60
        dest.z += 320
        
        dest = cartesianToGeographic(dest, meridian: LON_MERID_GREENWICH, a: A_WGS84, e: E_WGS84, eps: EPS)
    }
    
    return dest
}

extension CLLocation {
       public convenience init(x: Double, y: Double, inZone: LambertZone){
        
        
        let org:Point = Point(x: x, y: y, z: 0)
        var dest: Point = pointToWGS84(org, zone: inZone)
        let f : Double = 180.0/M_PI
        dest.x *= f
        dest.y *= f
        
        self.init(latitude: dest.y, longitude: dest.x)
        
    }
}
