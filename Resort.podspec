Pod::Spec.new do |s|
  s.name         = "Resort"
  s.version      = "0.3.0"
  s.summary      = "Simple, flexible sorting with Objective-C."
  s.description  = <<-DESC
                   Simple comparators library for sorting in Objective-C.

                   Support for building compound comparators,
                   reversing comparators, and creating new ones on top
                   of a keypath.

                   Compound compartors support combining individual
                   comparators for first, second and more sort keys
                   into a single one.

                   This is a very small library, for both OS X and
                   iOS.

                   DESC
  s.homepage     = "http://github.com/febeling/Resort"
  s.license      = 'MIT'
  s.author       = { "Florian Ebeling" => "florian.ebeling@gmail.com" }
  s.source       = { :git => "https://github.com/febeling/Resort.git", :tag => s.version.to_s }
  s.requires_arc = true
  s.source_files = 'Source'
end
