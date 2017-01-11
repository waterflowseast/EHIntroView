Pod::Spec.new do |s|
  s.name             = 'EHIntroView'
  s.version          = '1.0.0'
  s.summary          = 'A regular intro view.'

  s.description      = <<-DESC
A clean intro view. you have to build EHIntroPage all by yourself.
EHIntroView collects all EHIntroPage's touchUpInside events, and passes those events to its delegate.
                       DESC

  s.homepage         = 'https://github.com/waterflowseast/EHIntroView'
  s.screenshots     = 'https://github.com/waterflowseast/EHIntroView/raw/master/screenshots/1.png', 'https://github.com/waterflowseast/EHIntroView/raw/master/screenshots/2.png', 'https://github.com/waterflowseast/EHIntroView/raw/master/screenshots/3.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Eric Huang' => 'WaterFlowsEast@gmail.com' }
  s.source           = { :git => 'https://github.com/waterflowseast/EHIntroView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '7.0'
  s.source_files = 'EHIntroView/Classes/**/*'
  s.dependency 'EHItemViewCommon', '~> 1.0.0'
end
