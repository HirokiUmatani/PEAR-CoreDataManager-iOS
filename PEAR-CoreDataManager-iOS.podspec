Pod::Spec.new do |s|
   s.name     = 'PEAR-CoreDataManager-iOS'
   s.version  = '0.0.3'
   s.platform = :'ios', '7.0'
   s.license  = 'MIT'
   s.summary  = 'This ios library can be to create and manage the CoreData.'
   s.homepage = 'https://github.com/HirokiUmatani/PEAR-CoreDataManager-iOS'
   s.author   = { "HirokiUmatani" => "info@pear.chat" }
   s.source   = { :git => 'https://github.com/HirokiUmatani/PEAR-CoreDataManager-iOS.git', :tag => s.version.to_s }
   s.source_files = 'PEAR-CoreDataManager-iOS/*.{h,m}'
   s.requires_arc = true
end
