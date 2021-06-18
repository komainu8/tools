#! /bin/ruby

require 'fileutils'

def target_groonga_version
  [
    "10.1.1",
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
#        download_urls << "#{base_url}/groonga-#{groonga_version}-#{architecture}-#{vs_version}.zip"
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

def target_packages
  target_packages = []
  download_urls.each do |url|
    target_packages << File.basename(url)
  end
  target_packages
end

def uncompress(package)
  system("unzip", package)
end

def missing_groonga_admin_license?(package)
  false
end

def download_vcruntime_license(package)
  url =
    "https://raw.githubusercontent.com/groonga/groonga/master/packages/windows/vcruntime/ucrt-readme.txt"
  system("wget", url)
  if (package.include?("vs2017"))
    url =
      "https://raw.githubusercontent.com/groonga/groonga/master/packages/windows/vcruntime/vs2017/readme.txt"
  elsif(package.include?("vs2019"))
    url =
      "https://raw.githubusercontent.com/groonga/groonga/master/packages/windows/vcruntime/vs2019/readme.txt"
  end
  system("wget", url)
end

def missing_vcruntime_license?(package)
  vcruntime_dir = "share/groonga/vcruntime"
  p package
  if Dir.exist?(package)
    Dir.chdir(package) do
      if (Dir.exist?(vcruntime_dir))
        false
      else
        Dir.mkdir(vcruntime_dir)
        Dir.chdir(vcruntime_dir) do
          download_vcruntime_license(package)
        end
      end
    end
  elsif Dir.exist?("#{package}-with-vcruntime")
    Dir.chdir("#{package}-with-vcruntime") do
      if (Dir.exist?(vcruntime_dir))
        false
      else
        Dir.mkdir(vcruntime_dir)
        Dir.chdir(vcruntime_dir) do
          download_vcruntime_license(package)
        end
      end
    end
  else
    if (Dir.exist?(vcruntime_dir))
      false
    else
      Dir.mkdir(vcruntime_dir)
      Dir.chdir(vcruntime_dir) do
        download_vcruntime_license(package)
      end
    end
  end
end

def add_msgpack_license(package_path)
  msgpack_license_file = "share/groonga/msgpack/NOTICE"
  msgpack_license_dir = "share/groonga/msgpack/"
  url =
    "https://raw.githubusercontent.com/msgpack/msgpack-c/master/NOTICE"

  Dir.chdir(package_path) do
    unless File.file?(msgpack_license_file)
      Dir.chdir(msgpack_license_dir) do
        system("wget", url)
      end
    end
  end
end


def check_package(package)
  Dir.mkdir("org")
  system("cp", "#{package}.org", "org")
  Dir.chdir("org") do
    system("unzip", "-qq", "#{package}.org")
    FileUtils.rm_rf("#{package}.org")
  end
  system("unzip", "-qq", package)
  system("diff", "-r", File.basename(package, ".*").gsub(/-with-vcruntime/, ""), "org")
  FileUtils.rm_rf("org")
end

FileUtils.rm_rf("temp")
Dir.mkdir("temp")
Dir.chdir("temp") do
  download
  target_packages.each do |package|
    uncompress(package)
    system("mv", package, "#{package}.org")
    package_name = File.basename(package, ".*")
#    package_name = File.basename(package, ".*").gsub(/-with-vcruntime/, "")
    if Dir.exist?(package_name)
      system("chmod", "-R", "755", "#{package_name}/share")
      add_msgpack_license(package_name)
      system("zip", "-r", package, package_name)
      FileUtils.rm_rf(package_name)
    else
      Dir.mkdir(package_name)
      system("mv", "bin", "etc", "include", "lib", "share", package_name)
      system("sudo", "chmod", "-R", "755", "#{package_name}/share")
      add_msgpack_license(package_name)
      system("zip", "-r", package, package_name)
      FileUtils.rm_rf(package_name)
    end
#    if (missing_groonga_admin_license?(package_name))
#      add_groonga_admin_license(package_name)
#    end
#    if (missing_vcruntime_license?(package_name))
#      if (Dir.exist?(package_name))
#        p package
#        p package_name
#
#        system("zip", "-q", "-r", package, package_name)
#        FileUtils.rm_rf(package_name)
#      elsif Dir.exist?(File.basename(package, ".*"))
#        p package
#        p package_name
#
#        system("zip", "-q", "-r", package, File.basename(package, ".*"))
#        FileUtils.rm_rf(File.basename(package, ".*"))
#      else
#        Dir.mkdir(package_name)
#        system("mv", "bin", "etc", "include", "lib", "share", package_name)
#        p package
#        p package_name
#        system("zip", "-q", "-r", package, package_name)
#        system("ls")
#        FileUtils.rm_rf(package_name)
#        #      add_vcruntime_license(package_name)
#      end
#    end
#    check_package(package)
#    if (missing_msgpack_license?(package_name))
#      add_msgpack_license(package_name)
#    end
  end
end
