# SCPSL_Server_Tools
A collection of batchfiles designed to assist in the running of an SCPSL server

### Manual Installation
Go into your steam server install directory, and alongside the executable, create a folder named `tools`. Then download or copy each tool you want.

### Automatic Installation
Simply download from the [releases page](https://github.com/lordofkhaos/SCPSL_Server_Tools/releases/latest), extract a `tools` (doesnt matter which) then put the extracted folder to your main install directory. Then you can run each file from within the `tools` folder.


### Description
* **Autorun:** Creates a task for automatically running the files that makes sense.
* **Create Logkillers:** Creates files that delete old log files. Use `run_logkiller` to run them.
* **Run Logkillers:** Runs the log killers created with `create_logkillers`.
* **Find SteamIds:** Finds any and all steamid64's in your MultiAdmin logs and outputs them to a `.csv` file in the `tools` directory. 
#
Actually, with the latest update to `find_steamids.bat`, you should be able to open up `results.csv` in Excel just fine
~~NOTE: It is not recommended to open `results.csv` with Excel as it *will* mess up the steamids, since it doesn't like really long numbers~~
