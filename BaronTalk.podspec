Pod::Spec.new do |s|
    s.name = "BaronTalk"
    s.version = "1.0.0"
    s.summary = "Chat app backend wrapper"
    s.homepage = "https://github.com/alicerunsonfedora/BaronTalk"
    s.author = { "Marquis Kurt and Team" => "marquis.kurt@enhanceit.us" }
    s.source = { :git => "https://github.com/alicerunsonfedora/BaronTalk", :tag => s.version.to_s }
    s.ios_deployment_target = "15.0"
    s.swift_version = "5.6"
    s.source_files = "Sources/BaronTalk/**/*"
end