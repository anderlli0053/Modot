## Contains utility methods for [Directory].
class_name DirectoryExtensions

## Returns the complete paths of all subdirectories inside [code]directory[/code], searching recursively.
static func get_directories_recursive(directory):
	var directories = []
	for subdir_path in directory.get_directories():
		var path_full = directory.get_current_dir().path_join(subdir_path)
		directories.append(path_full)
		var subdir = Directory.new()
		subdir.open(path_full)
		directories.append_array(DirectoryExtensions.get_directories_recursive(subdir))
	return directories

## Returns the complete paths of all files inside [code]directory[/code], searching recursively.
static func get_files_recursive(directory):
	var files = []
	for file_path in directory.get_files():
		files.append(directory.get_current_dir().path_join(file_path))
	for subdir_path in DirectoryExtensions.get_directories_recursive(directory):
		var subdir = Directory.new()
		subdir.open(directory.get_current_dir().path_join(subdir_path))
		files.append_array(subdir.get_files())
	return files

## Returns the complete file paths of all files inside [code]directory[/code] whose extensions match any of [code]extensions[/code], searching recursively.
static func get_files_recursive_ending(directory, extensions):
	return DirectoryExtensions.get_files_recursive(directory).filter(func(file_path): return extensions.any(func(extension): return file_path.ends_with(".%s" % extension)))
