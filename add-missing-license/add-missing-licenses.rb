#! /bin/ruby

require 'fileutils'

def target_groonga_version
  [
    "10.0.5",
    "10.0.6",
    "10.0.7",
    "10.0.8",
    "10.0.9",
    "10.1.0",
    "10.1.1",
    "11.0.0",
    "11.0.1",
  ]
end

def target_architecture
  [
    "x86",
    "x64",
  ]
end

def target_vs_version
  [
    "vs2015",
    "vs2017",
    "vs2019",
  ]
end

def download_urls
  download_urls = []
  base_url = "https://packages.groonga.org/windows/groonga"
  target_groonga_version.each do |groonga_version|
    target_architecture.each do |architecture|
      target_vs_version.each do |vs_version|
        download_urls << "#{base_url}/groonga-#{groonga_version}-#{architecture}-#{vs_version}-with-vcruntime.zip"
        download_urls << "#{base_url}/groonga-#{groonga_version}-#{architecture}-#{vs_version}.zip"
      end
    end
  end
  download_urls
end

def download
  download_urls.each do |url|
    system("wget", url)
  end
end

FileUtils.rm_rf("temp")
Dir.mkdir("temp")
Dir.chdir("temp") do
  download
end
#FileUtils.rm_rf("temp")
