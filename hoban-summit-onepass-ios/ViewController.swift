//
//  ViewController.swift
//  hoban-summit-onepass-ios
//
//  Created by Seohun Uhm on 2020/01/26.
//  Copyright © 2020 uhmtoto. All rights reserved.
//

import UIKit

import CoreBluetooth
import CoreLocation

class ViewController: UIViewController, CBPeripheralManagerDelegate {
    var localBeacon: CLBeaconRegion!
    var beaconPeripheralData: NSDictionary!
    var peripheralManager: CBPeripheralManager!

    func initLocalBeacon () {
        if localBeacon != nil {
            stopLocalBeacon()
        }

        let localBeaconUUID = UUID(uuidString: "54573114-0102-3203-3425-201062190152")!
        let localBeaconMajor: CLBeaconMajorValue = 123
        let localBeaconMinor: CLBeaconMinorValue = 456

        localBeacon = CLBeaconRegion(proximityUUID: localBeaconUUID, major: localBeaconMajor, minor: localBeaconMinor, identifier: "identifier")

        beaconPeripheralData = localBeacon.peripheralData(withMeasuredPower: nil)
        peripheralManager = CBPeripheralManager(delegate: self, queue: nil, options: nil)
    }

    func stopLocalBeacon () {
        peripheralManager.stopAdvertising()
        peripheralManager = nil
        beaconPeripheralData = nil
        localBeacon = nil
    }

    func peripheralManagerDidUpdateState (_ peripheral: CBPeripheralManager) {
        if peripheral.state == .poweredOn {
            peripheralManager.startAdvertising(beaconPeripheralData as? [String: Any])
        } else if peripheral.state == .poweredOff {
            peripheralManager.stopAdvertising()
        }
    }
    
    @IBAction func reTransmit(_ sender: Any) {
        initLocalBeacon()
    }
    
    override func viewDidLoad () {
        initLocalBeacon()
    }
}

