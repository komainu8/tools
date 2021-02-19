#!/bin/ruby

require 'fileutils'
#require 'zip'

class Packages

  def initialize
    @names = make_package_names
  end

  def download
    @names.each do |name|
      next if File.file?(name)
      system("wget #{base_url}/#{name}")
    end
  end

  def get_names
    @names
  end

  private
  def target_groonga_versions
    [
      "10.0.4",
      "10.0.5",
      "10.0.6",
      "10.0.7",
      "10.0.8",
      "10.0.9",
      "10.1.0",
      "10.1.1"
    ]
  end

  def target_architectures
    [
      "x86",
      "x64"
    ]
  end

  def support_vs_versions
    {
      "10.0.4" => ["vs2013", "vs2015", "vs2017"],
      "10.0.5" => ["vs2015", "vs2017", "vs2019"],
      "10.0.6" => ["vs2015", "vs2017", "vs2019"],
      "10.0.7" => ["vs2015", "vs2017", "vs2019"],
      "10.0.8" => ["vs2017", "vs2019"],
      "10.0.9" => ["vs2017", "vs2019"],
      "10.1.0" => ["vs2017", "vs2019"],
      "10.1.1" => ["vs2017", "vs2019"]
    }
  end

  #msgpack_file_paths = [
  #  "./share/groonga/msgpack/NOTICE"
  #]
  #
  #vcruntime_file_paths = [
  #  "./share/groonga/vcruntime/readme.txt",
  #  "./share/groonga/vcruntime/ucrt-readme.txt"
  #]

  def base_url
    "http://packages.groonga.org/windows/groonga"
  end

  def make_package_names
    package_names = []
    target_groonga_versions.each do |groonga_version|
      package_name_with_groonga_version = "groonga-#{groonga_version}"
      target_architectures.each do |architecture|
        package_name_with_arch = package_name_with_groonga_version + "-#{architecture}"
        support_vs_versions[groonga_version].each do |support_vs_version|
          package_names << (package_name_with_arch + "-#{support_vs_version}.zip")
          package_names << (package_name_with_arch + "-#{support_vs_version}-with-vcruntime.zip")
        end
      end
    end
    package_names
  end
end

class Package
  def initialize(name)
    @name = name
  end

  def uncompress
    system("unzip #{@name}")
  end

  def get_path
    return basename if Dir.exist?(basename)

    Dir.mkdir(basename, 0755)
    FileUtils.mv(target_directories, basename)

    basename
  end

  private
  def basename
    File.basename(@name, ".zip")
  end

  def groonga_admin_paths
    [
      "share/groonga/groonga-admin",
      "share/groonga/groonga-admin/LICENSE",
      "share/groonga/groonga-admin/README.md"
    ]
  end

  def groonga_admin_url
    "https://packages.groonga.org/source/groonga-admin/groonga-admin.tar.gz"
  end

  def groonga_admin_archive_name
    File.basename(groonga_admin_url)
  end

  def groonga_admin_version
    "0.9.6"
  end

  def groonga_admin_basename
    File.basename(groonga_admin_archive_name, ".tar.gz")
  end

  def download_groonga_admin
    system("wget #{groonga_admin_url}")
  end

  def groonga_admin_bundle_directory
    "share/groonga/html"
  end

end

packages = Packages.new()
packages.download()

packages.get_names().each do |name|
  package = Package.new(name)

  package.uncompress()
  system("mv #{name} #{name}.old")
end

#download_packages.each do |package|
#  updated = false
#
#  dirname = File.basename(package, ".zip")
#
#  download_url = "#{base_url}/#{package}"
#  sh("wget", download_url)
#  sh("cp", package, "#{package}.org")
#  unzip_success = true
#  sh("unzip", "-q", package) do |success, rc|
#    unzip_success = success
#    unless success
#      sh("rm", package, "#{package}.org")
#      if Dir.exist?(dirname)
#        sh("sudo", "rm", "-rf", dirname)
#      elsif Dir.exist?(File.basename(dirname, "-with-vcruntime"))
#        sh("sudo", "rm", "-rf", File.basename(dirname, "-with-vcruntime"))
#      end
#    end
#  end
#  next unless unzip_success
#  sh("rm", package)
#
#  if Dir.exist?(dirname)
#    Dir.chdir(dirname)
#  elsif Dir.exist?(File.basename(dirname, "-with-vcruntime"))
#    Dir.chdir(File.basename(dirname, "-with-vcruntime"))
#  end
#  sh("sudo", "chmod", "755", "./share")
#  sh("sudo", "chmod", "755", "./share/groonga/html")
#
#  groonga_admin_url = "https://packages.groonga.org/source/groonga-admin/groonga-admin.tar.gz"
#  groonga_admin_archive_name = File.basename(groonga_admin_url)
#  groonga_admin_version = "0.9.6"
#
#  groonga_admin_file_paths.each do |path|
#    next if File.exist?(path)
#
#    cd("./share/groonga/html") do
#      sh("mv", "admin", "admin.old")
#      sh("wget", groonga_admin_url)
#      sh("tar", "-xf", groonga_admin_archive_name)
#      sh("rm", "-rf", groonga_admin_archive_name)
#      sh("mv", "groonga-admin-#{groonga_admin_version}/html", "admin")
#      sh("rm", "-rf", "groonga-admin-#{groonga_admin_version}/source")
#      sh("mv", "groonga-admin-#{groonga_admin_version}", "../groonga-admin")
#      updated = true
#    end
#    break
#  end
#
#  download_msgpack_version = "3.0.1"
#  download_url = "https://github.com/msgpack/msgpack-c/releases/download/cpp-#{download_msgpack_version}/msgpack-#{download_msgpack_version}.tar.gz"
#  msgpack_archive_name = File.basename(download_url)
#  msgpack_dir_name = File.basename(msgpack_archive_name, ".tar.gz")
#  groonga_license_dir = "../share/groonga/msgpack"
#
#  msgpack_file_paths.each do |path|
#    next if File.exist?(path)
#
#    sh("wget", download_url)
#    sh("tar", "-xf", msgpack_archive_name)
#    cd(msgpack_dir_name) do
#      sh("mv", "AUTHORS", groonga_license_dir)
#      sh("mv", "COPYING", groonga_license_dir)
#      sh("mv", "ChangeLog", groonga_license_dir)
#      sh("mv", "LICENSE_1_0.txt", groonga_license_dir)
#      sh("mv", "NOTICE", groonga_license_dir)
#      sh("mv", "README.md", groonga_license_dir)
#      updated = true
#    end
#    sh("rm", "-rf", msgpack_archive_name, msgpack_dir_name)
#    break
#  end
#
#  vcruntime_file_paths.each do |path|
#    break unless package.include?("-with-vcruntime")
#    next if File.exist?(path)
#    next if package.include?("vs2013") && path.include?("ucrt-readme.txt")
#
#    vs_version = ""
#    if package.include?("vs2013")
#      vs_version = "vs2013"
#    elsif package.include?("vs2015")
#      vs_version = "vs2015"
#    elsif package.include?("vs2017")
#      vs_version = "vs2017"
#    elsif package.include?("vs2019")
#      vs_version = "vs2019"
#    end
#
#    sh("git", "clone", "https://github.com/groonga/groonga.git", "groonga.master")
#    sh("cp",
#       "./groonga.master/packages/windows/vcruntime/ucrt-readme.txt",
#       "./groonga.master/packages/windows/vcruntime/#{vs_version}/readme.txt",
#       "./share/groonga/vcruntime/")
#    sh("rm", "-rf", "groonga.master")
#    updated = true
#  end
#
#  cd("../")
#  if updated
#    if Dir.exist?(dirname)
#      sh("zip", "#{dirname}.zip", "-r", dirname)
#      sh("sudo", "rm", "-rf", dirname)
#    elsif Dir.exist?(File.basename(dirname, "-with-vcruntime"))
#      sh("zip", "#{dirname}.zip", "-r", File.basename(dirname, "-with-vcruntime"))
#      sh("sudo", "rm", "-rf", File.basename(dirname, "-with-vcruntime"))
#    end
#  else
#    sh("rm", "-rf", "./groonga-*")
#  end
#end
