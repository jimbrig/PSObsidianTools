$VaultName = ''
$VaultId = ''
$FileName = ''

$USER_HOME = [Environment]::GetFolderPath('UserProfile')

$OBSIDIAN_CONFIG_PATH = "$USER_HOME\AppData\Roaming\obsidian\"

$OBSIDIAN_URI_OPEN = "obsidian://advanced-uri?vault=$VaultId&file=$FileName"
$OBSIDIAN_URI_SEARCH = 'obsidian://search?vault={vault_id}&query={query}'

$OBSIDIAN_APPDATA_PATH_WINDOWS = "$Env:APPDATA\obsidian\"
$OBSIDIAN_APPDATA_PATH_DARWIN = "$USER_HOME/Library/Application Support/obsidian/"
$OBSIDIAN_APPDATA_PATH_LINUX = "$USER_HOME/.config/obsidian/"

$OBSIDIAN_OPEN_CMD = 'obsidian://advanced-uri?vault={vault_id}&file={file_name}'
