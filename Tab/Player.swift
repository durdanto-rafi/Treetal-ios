//
//  ChildViewController1.swift
//  Tab
//
//  Created by kjs-mac03 on 2017/11/20.
//  Copyright © 2017 Radio Treetal Bangla. All rights reserved.
//

import UIKit
import XLPagerTabStrip
import AVFoundation
import SystemConfiguration
import ESTMusicIndicator

class Player: UIViewController, IndicatorInfoProvider {
    
    @IBOutlet weak var esMusicView: ESTMusicIndicatorView!
    // Initialization
    var avPlayer: AVPlayer!
    @IBOutlet weak var btnPlay: UIButton!
    var playTapped : Bool = false
    
    // Indicator Info for current selected screen
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo
    {
        return IndicatorInfo(title: "RADIO")
    }
    
    // Play Button Listner
    @IBAction func btnPlayTapped(_ sender: Any)
    {
        if !playTapped
        {
            if isInternetAvailable()
            {
                print("Haz Interwebz!")
                btnPlay.setImage(UIImage(named: "stop"), for: UIControlState.normal)
                self.getStreamingLink()
                playTapped = true
            }
            else
            {
                print("Oh noes! No interwebz!!!")
                showALert(title: "Warning !", message: "Connect to Internet first")
            }
        }
        else
        {
            avPlayer.pause()
            playTapped = false
            btnPlay.setImage(UIImage(named: "play"), for: UIControlState.normal)
        }
        
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let indicator = ESTMusicIndicatorView.init(frame: CGRect.zero)
        indicator.tintColor = .red
        indicator.sizeToFit()
        indicator.state = .playing;
        esMusicView.addSubview(indicator)
        //esMusicView = indicator
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //Getting URL link to play
    func getStreamingLink()
    {
        guard let url = URL(string : "http://radiotreetalbangla.com/api/v1/stream?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE1MDYxNTQ0MzIsImp0aSI6IkRrZ1dUU0tsbDB1WTBEdnplR1pyZnZ1YUc0bXYwa0kzeFdXN05sczZOQ0R5aWV6Z1BlbjhuZnNyUmxNc2NNWGQiLCJpc3MiOiJ3d3cucmFkaW90cmVldGFsYmFuZ2xhLmNvbSIsIm5iZiI6MTUwNjE1NDQ0MiwiZXhwIjoxNTM3NjkwNDMyfQ.MECm1Cd5r4-C89p-PMKu6pVu5voie6g4daX_LJyttHNUsTzwoVgm0cBZXdbB-LAkYi2nNZqiQ9HJkYgUWPuSbw") else { return }
        let session = URLSession.shared
        
        session.dataTask(with: url)
        {
            (data, response, err) in
            if let data = data
            {
                self.preparePlayer(link: String(data: data, encoding: .utf8)!)
            }
        }.resume()
    }
    
    
    //Play
    func preparePlayer(link : String)
    {
        let playerItem = AVPlayerItem(url: URL(string: link)!)
        avPlayer = AVPlayer(playerItem: playerItem)
        
        let session = AVAudioSession.sharedInstance()
        do
        {
            // Configure the audio session for movie playback
            try session.setCategory(AVAudioSessionCategoryPlayback, mode: AVAudioSessionModeMoviePlayback, options: [])
        }
        catch let error as NSError
        {
            print("Failed to set the audio session category and mode: \(error.localizedDescription)")
        }
        
        avPlayer.play()
    }
    
    // Checking for Internet connectivity
    func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress)
        {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1)
            {
                zeroSockAddress in SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags)
        {
            return false
        }
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        return (isReachable && !needsConnection)
    }
    
    // Displaying Alert
    func showALert(title : String, message : String)
    {
        let alertController = UIAlertController(title: title, message:message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
