require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Nomadic" do

  describe "user agent detection" do

    def should_detect_agent(expectation, user_agent)
      env = { "HTTP_USER_AGENT" => user_agent }
      Nomadic.mobile?(env).should == expectation
    end

    it "should detect iPhones and iPod Touch's" do
      should_detect_agent(:iphone, "Mozilla/5.0 (iPhone; U; CPU like Mac OS X; en) AppleWebKit/420.1 (KHTML, like Gecko) Version/3.0 Mobile/1A542a Safari/419.3")
      should_detect_agent(:iphone, "Mozila/5.0 (iPod; U; CPU like Mac OS X; en) AppleWebKit/420.1 (KHTML, like Gecko) Version/3.0 Mobile/3A101a Safari/419.3")
    end
    
    it "should reject iPad's" do
      env = { "HTTP_USER_AGENT" => "Mozilla/5.0 (iPad; U; CPU OS 3_2 like Mac OS X; en-us) AppleWebKit/531.21.10 (KHTML, like Gecko) Version/4.0.4 Mobile/7B367 Safari/531.21.10" }
      Nomadic.mobile?(env).should == nil
    end

    it "should detect Android handset" do
      should_detect_agent(:android, "Mozilla/5.0 (Linux; U; Android 1.5; de-; sdk Build/CUPCAKE) AppleWebkit/528.5+ (KHTML, like Gecko) Version/3.1.2 Mobile Safari/525.20.1")
    end

    it "should detect Opera Mini browsers" do
      should_detect_agent(:opera, "Opera/9.50 (J2ME/MIDP; Opera Mini/4.0.10031/298; U; en)")
    end

    it "should detect Blackberrys" do
      should_detect_agent(:blackberry, "BlackBerry7100i/4.1.0 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/103")
      should_detect_agent(:blackberry, "Mozilla/4.0 BlackBerry8100/4.2.0 Profile/MIDP-2.0 Configuration/CLDC-1.1 VendorID/100")
    end

    it "should detect Palm handsets" do
      should_detect_agent(:palm, "Mozilla/5.0 (Danger hiptop 3.4; U; AvantGo 3.2)")
      should_detect_agent(:palm, "Mozilla/1.22 (compatible; MSIE 5.01; PalmOS 3.0) EudoraWeb 2.1")
    end

    it "should detect Windows CE" do
      should_detect_agent(:windows, "Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 6.12) PPC; 240x320; HTC P3450; OpVer 23.116.1.611")
      should_detect_agent(:windows, "AMSUNG-SGH-I617/1.0 Mozilla/4.0 (compatible; MSIE 6.0; Windows CE; IEMobile 6.12) UP.Link/6.3.0.0.0")
    end

    it "should detect other mobile devices" do
      should_detect_agent(:other, "NokiaN75-3/3.0 (1.0635.0.0.6); SymbianOS/9.1 Series60/3.0 Profile/MIDP-2.0 Configuration/CLDC-1.1) UP.Link/6.3.0.0")
      should_detect_agent(:other, "SAMSUNG-SGH-U900-Vodafone/U900BUHD6 SHP/VPP/R5 NetFront/3.4 Qtv5.3 SMM-MMS/1.2.0 profile/MIDP-2.0 configuration/CLDC-1.1")
    end

  end

  describe "other header detection" do

    it "should detect WAP HTTP ACCEPT headers" do
      env = { "HTTP_ACCEPT" => "text/vnd.wap.wml" }

      Nomadic.mobile?(env).should == :wap_accept
    end

    it "should detect WAP PROFILE headers" do
      env = { "HTTP_X_WAP_PROFILE" => "http://uaprof.vtext.com/lg/vx4500/vx4500.xml" }

      Nomadic.mobile?(env).should == :wap_profile
    end

  end

end