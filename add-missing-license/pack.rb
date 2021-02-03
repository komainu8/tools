require 'rake'
require 'zip'

download_packages = [
  "groonga-10.0.4-x64-vs2013-with-vcruntime.zip",
  "groonga-10.0.4-x64-vs2015-with-vcruntime.zip",
  "groonga-10.0.4-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.4-x64-vs2013.zip",
  "groonga-10.0.4-x64-vs2015.zip",
  "groonga-10.0.4-x64-vs2017.zip",
  "groonga-10.0.4-x64.zip",

  "groonga-10.0.4-x86-vs2013-with-vcruntime.zip",
  "groonga-10.0.4-x86-vs2015-with-vcruntime.zip",
  "groonga-10.0.4-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.4-x86-vs2013.zip",
  "groonga-10.0.4-x86-vs2015.zip",
  "groonga-10.0.4-x86-vs2017.zip",
  "groonga-10.0.4-x86.zip",

  "groonga-10.0.5-x64-vs2015-with-vcruntime.zip",
  "groonga-10.0.5-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.5-x64-vs2019-with-vcruntime.zip",
  "groonga-10.0.5-x64-vs2015.zip",
  "groonga-10.0.5-x64-vs2017.zip",
  "groonga-10.0.5-x64-vs2019.zip",
  "groonga-10.0.5-x64.zip",

  "groonga-10.0.5-x86-vs2015-with-vcruntime.zip",
  "groonga-10.0.5-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.5-x86-vs2019-with-vcruntime.zip",
  "groonga-10.0.5-x86-vs2015.zip",
  "groonga-10.0.5-x86-vs2017.zip",
  "groonga-10.0.5-x86-vs2019.zip",
  "groonga-10.0.5-x86.zip",

  "groonga-10.0.6-x64-vs2015-with-vcruntime.zip",
  "groonga-10.0.6-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.6-x64-vs2019-with-vcruntime.zip",
  "groonga-10.0.6-x64-vs2015.zip",
  "groonga-10.0.6-x64-vs2017.zip",
  "groonga-10.0.6-x64-vs2019.zip",
  "groonga-10.0.6-x64.zip",

  "groonga-10.0.6-x86-vs2015-with-vcruntime.zip",
  "groonga-10.0.6-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.6-x86-vs2019-with-vcruntime.zip",
  "groonga-10.0.6-x86-vs2015.zip",
  "groonga-10.0.6-x86-vs2017.zip",
  "groonga-10.0.6-x86-vs2019.zip",
  "groonga-10.0.6-x86.zip",

  "groonga-10.0.7-x64-vs2015-with-vcruntime.zip",
  "groonga-10.0.7-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.7-x64-vs2019-with-vcruntime.zip",
  "groonga-10.0.7-x64-vs2015.zip",
  "groonga-10.0.7-x64-vs2017.zip",
  "groonga-10.0.7-x64-vs2019.zip",
  "groonga-10.0.7-x64.zip",

  "groonga-10.0.7-x86-vs2015-with-vcruntime.zip",
  "groonga-10.0.7-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.7-x86-vs2019-with-vcruntime.zip",
  "groonga-10.0.7-x86-vs2015.zip",
  "groonga-10.0.7-x86-vs2017.zip",
  "groonga-10.0.7-x86-vs2019.zip",
  "groonga-10.0.7-x86.zip",

  "groonga-10.0.8-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.8-x64-vs2019-with-vcruntime.zip",
  "groonga-10.0.8-x64-vs2017.zip",
  "groonga-10.0.8-x64-vs2019.zip",
  "groonga-10.0.8-x64.zip",

  "groonga-10.0.8-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.8-x86-vs2019-with-vcruntime.zip",
  "groonga-10.0.8-x86-vs2017.zip",
  "groonga-10.0.8-x86-vs2019.zip",
  "groonga-10.0.8-x86.zip",

  "groonga-10.0.9-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.9-x64-vs2019-with-vcruntime.zip",
  "groonga-10.0.9-x64-vs2017.zip",
  "groonga-10.0.9-x64-vs2019.zip",
  "groonga-10.0.9-x64.zip",

  "groonga-10.0.9-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.9-x86-vs2019-with-vcruntime.zip",
  "groonga-10.0.9-x86-vs2017.zip",
  "groonga-10.0.9-x86-vs2019.zip",
  "groonga-10.0.9-x86.zip",

  "groonga-10.0.10-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.10-x64-vs2019-with-vcruntime.zip",
  "groonga-10.0.10-x64-vs2017.zip",
  "groonga-10.0.10-x64-vs2019.zip",
  "groonga-10.0.10-x64.zip",

  "groonga-10.0.10-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.10-x86-vs2019-with-vcruntime.zip",
  "groonga-10.0.10-x86-vs2017.zip",
  "groonga-10.0.10-x86-vs2019.zip",
  "groonga-10.0.10-x86.zip",

  "groonga-10.0.11-x64-vs2017-with-vcruntime.zip",
  "groonga-10.0.11-x64-vs2019-with-vcruntime.zip",
  "groonga-10.0.11-x64-vs2017.zip",
  "groonga-10.0.11-x64-vs2019.zip",
  "groonga-10.0.11-x64.zip",

  "groonga-10.0.11-x86-vs2017-with-vcruntime.zip",
  "groonga-10.0.11-x86-vs2019-with-vcruntime.zip",
  "groonga-10.0.11-x86-vs2017.zip",
  "groonga-10.0.11-x86-vs2019.zip",
  "groonga-10.0.11-x86.zip"
]

groonga_admin_file_paths = [
  "./share/groonga/groonga-admin",
  "./share/groonga/groonga-admin/LICENSE",
  "./share/groonga/groonga-admin/README.md",
]

msgpack_file_paths = [
  "./share/groonga/msgpack/NOTICE"
]

base_url = "http://packages.groonga.org/windows/groonga"

download_packages.each do |package|
  dirname = File.basename(package, ".zip")

  download_url = "#{base_url}/#{package}"
  sh("wget", download_url)
  sh("cp", package, "#{package}.org")
  unzip_success = true
  sh("unzip", "-q", package) do |success, rc|
    unzip_success = success
    unless success
      sh("rm", package, "#{package}.org")
      if Dir.exist?(dirname)
        sh("sudo", "rm", "-rf", dirname)
      elsif Dir.exist?(File.basename(dirname, "-with-vcruntime"))
        sh("sudo", "rm", "-rf", File.basename(dirname, "-with-vcruntime"))
      end
    end
  end
  next unless unzip_success
  sh("rm", package)

  if Dir.exist?(dirname)
    Dir.chdir(dirname)
  elsif Dir.exist?(File.basename(dirname, "-with-vcruntime"))
    Dir.chdir(File.basename(dirname, "-with-vcruntime"))
  end
  sh("sudo", "chmod", "755", "./share")
  sh("sudo", "chmod", "755", "./share/groonga/html")

  groonga_admin_url = "https://packages.groonga.org/source/groonga-admin/groonga-admin.tar.gz"
  groonga_admin_archive_name = File.basename(groonga_admin_url)
  groonga_admin_version = "0.9.6"

  groonga_admin_file_paths.each do |path|
    next if File.exist?(path)

    cd("./share/groonga/html") do
      sh("mv", "admin", "admin.old")
      sh("wget", groonga_admin_url)
      sh("tar", "-xf", groonga_admin_archive_name)
      sh("rm", "-rf", groonga_admin_archive_name)
      sh("mv", "groonga-admin-#{groonga_admin_version}/html", "admin")
      sh("rm", "-rf", "groonga-admin-#{groonga_admin_version}/source")
      sh("mv", "groonga-admin-#{groonga_admin_version}", "../groonga-admin")
      updated = true
    end
    break
  end

  download_msgpack_version = "3.0.1"
  download_url = "https://github.com/msgpack/msgpack-c/releases/download/cpp-#{download_msgpack_version}/msgpack-#{download_msgpack_version}.tar.gz"
  msgpack_archive_name = File.basename(download_url)
  msgpack_dir_name = File.basename(msgpack_archive_name, ".tar.gz")
  groonga_license_dir = "../share/groonga/msgpack"

  msgpack_file_paths.each do |path|
    next if File.exist?(path)

    sh("wget", download_url)
    sh("tar", "-xf", msgpack_archive_name)
    cd(msgpack_dir_name) do
      sh("mv", "AUTHORS", groonga_license_dir)
      sh("mv", "COPYING", groonga_license_dir)
      sh("mv", "ChangeLog", groonga_license_dir)
      sh("mv", "LICENSE_1_0.txt", groonga_license_dir)
      sh("mv", "NOTICE", groonga_license_dir)
      sh("mv", "README.md", groonga_license_dir)
      updated = true
    end
    sh("rm", "-rf", msgpack_archive_name, msgpack_dir_name)
    break
  end

end
