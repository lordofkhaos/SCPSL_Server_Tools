import os, sys, time, glob

cwd = os.getcwd()
scp = os.path.dirname(cwd)

def clear():
	# for windows 
	if os.name == 'nt': 
		_ = os.system('cls')
	else: 
		_ = os.system('clear')

def printProgressBar (iteration, total, prefix = '', suffix = '', decimals = 1, length = 100, fill = '#'):
	"""
	Call in a loop to create terminal progress bar
	@params:
		iteration   - Required  : current iteration (Int)
		total	   - Required  : total iterations (Int)
		prefix	  - Optional  : prefix string (Str)
		suffix	  - Optional  : suffix string (Str)
		decimals	- Optional  : positive number of decimals in percent complete (Int)
		length	  - Optional  : character length of bar (Int)
		fill		- Optional  : bar fill character (Str)
	"""
	percent = ("{0:." + str(decimals) + "f}").format(100 * (iteration / float(total)))
	filledLength = int(length * iteration // total)
	bar = fill * filledLength + '.' * (length - filledLength)
	print('\r%s [%s] %s%% %s' % (prefix, bar, percent, suffix), end = '\r')
	# Print New Line on Complete
	if iteration == total: 
		print()

# Delete the old logkillers
def delscp():
	os.chdir(scp)
	if os.path.exists("servers"):
		os.chdir("servers")
		filenames = os.listdir(".")
		result = []
		for filename in filenames:
			if os.path.isdir(os.path.join(os.path.abspath("."), filename)):
				result.append(filename)
		for subdir in result:
			if os.path.exists("$scp_logkiller.bat"):
				os.remove("$scp_logkiller.bat")
	else:
		if os.path.exists("logs"):
			os.chdir("logs")
			filenames = os.listdir(".")
			result = []
			for filename in filenames:
				if os.path.isdir(os.path.join(os.path.abspath("."), filename)):
				result.append(filename)
			for subdir in result:
				if os.path.exists("$scp_logkiller.bat"):
					os.remove("$scp_logkiller.bat")
				elif os.path.exists("_scp_logkiller.sh"):
					os.remove("_scp_logkiller.sh")
		else:
			print("Error! Logs folder not detected!")

def delma():
	os.chdir(scp)
	if os.path.exists("servers"):
		os.chdir("servers")
		filenames = os.listdir(".")
		result = []
		for filename in filenames:
			if os.path.isdir(os.path.join(os.path.abspath("."), filename)):
				result.append(filename)
		for subdir in result:
			if os.path.exists("$ma_logkiller.bat"):
				os.remove("$ma_logkiller.bat")
			elif os.path.exists("_ma_logkiller.sh"):
				os.remove("_ma_logkiller.sh")
	else:
		if os.path.exists("logs"):
			os.chdir("logs")
			filenames = os.listdir(".")
			result = []
			for filename in filenames:
				if os.path.isdir(os.path.join(os.path.abspath("."), filename)):
				result.append(filename)
			for subdir in result:
				if os.path.exists("$ma_logkiller.bat"):
					os.remove("$ma_logkiller.bat")
				elif os.path.exists("_ma_logkiller.sh"):
					os.remove("_ma_logkiller.sh")
		else:
			print("Error! Logs folder not detected!")

def delround(): 
	if os.name == 'nt':
		os.chdir(os.getenv('APPDATA'))
		if os.path.exists("SCP Secret Laboratory\ServerLogs"):
			os.chdir("SCP Secret Laboratory\ServerLogs")
			filenames = os.listdir(".")
			result = []
			for filename in filenames:
				if os.path.isdir(os.path.join(os.path.abspath("."), filename)):
					result.append(filename)
			for subdir in result:
				if os.path.exists("$round_logkiller.bat"):
					os.remove("$round_logkiller.bat")
	else:
		os.chdir(os.getenv('HOME'))
		os.chdir(".config/SCP Secret Laboratory/ServerLogs")
		filenames = os.listdir(".")
		result = []
		for filename in filenames:
			if os.path.isdir(os.path.join(os.path.abspath("."), filename)):
			result.append(filename)
		for subdir in result:
			if os.path.exists("_round_logkiller.sh"):
				os.remove("_round_logkiller.sh")

def delat():
	if os.name == 'nt':
		os.chdir(os.getenv('APPDATA'))
		if os.path.exists("SCP Secret Laboratory\AdminToolbox\ServerLogs"):
			os.chdir("SCP Secret Laboratory\AdminToolbox\ServerLogs")
			filenames = os.listdir(".")
			result = []
			for filename in filenames:
				if os.path.isdir(os.path.join(os.path.join.abspath("."), filename)):
					result.append(filename)
			for subdir in result:
				if os.path.exists("$at_logkiller.bat"):
					os.remove("$at_logkiller.bat")
	else:
		os.chdir(os.getenv('HOME'))
		os.chdir(".config/SCP Secret Laboratory/AdminToolbox/ServerLogs")
		filenames = os.listdir(".")
		result = []
		for filename in filenames:
			if os.path.isdir(os.path.join(os.path.abspath("."), filename)):
			result.append(filename)
		for subdir in result:
			if os.path.exists("_at_logkiller.sh"):
				os.remove("_at_logkiller.sh")

# Delete logs
def remscp(days):
	os.chdir(scp)
	if os.path.exists("servers"):
		os.chdir("servers")
		filenames = os.listdir(".")
		result = []
		for filename in filenames:
			if os.path.isdir(os.path.join(os.path.abspath("."), filename)):
				result.append(filename)
		l = len(result)
		printProgressBar(0, l, prefix = "Progress:", suffix = "Complete", length = 50)
		for i, subdir in enumerate(result):
			# files = os.listdir(".")
			for file in glob.glob("*SCP_output_log.txt"):
				time_in_secs = time.time() - (days * 24 * 60 * 60)
				stat = os.stat(file)

				if stat.st_mtime <= time_in_secs:
					remove(file)
			time.sleep(0.1)
			printProgressBar(i + 1, l, prefix = "Progress:", suffix = "Complete", length = 50)
	else:
		if os.path.exists("logs"):
			os.chdir("logs")
			filenames = os.listdir(".")
			result = []
			for filename in filenames:
				if os.path.isdir(os.path.join(os.path.abspath("."), filename)):
				result.append(filename)
			l = len(result)
			printProgressBar(0, l, prefix = "Progress:", suffix = "Complete", length = 50)
			for i, subdir in enumerate(result):
				for file in glob.glob("*SCP_output_log.txt"):
					time_in_secs = time.time() - (days * 24 * 60 * 60)
					stat = os.stat(file)

					if stat.st_mtime <= time_in_secs:
						remove(file)
				time.sleep(0.1)
				printProgressBar(i + 1, l, prefix = "Progress:", suffix = "Complete", length = 50)
		else:
			print("Error! Logs folder not detected!")

def remma(days):
	os.chdir(scp)
	if os.path.exists("servers"):
		os.chdir("servers")
		filenames = os.listdir(".")
		result = []
		for filename in filenames:
			if os.path.isdir(os.path.join(os.path.abspath("."), filename)):
				result.append(filename)
		l = len(result)
		printProgressBar(0, l, prefix = "Progress:", suffix = "Complete", length = 50)
		for i, subdir in enumerate(result):
			# files = os.listdir(".")
			for file in glob.glob("*MA_output_log.txt"):
				time_in_secs = time.time() - (days * 24 * 60 * 60)
				stat = os.stat(file)

				if stat.st_mtime <= time_in_secs:
					remove(file)
			time.sleep(0.1)
			printProgressBar(i + 1, l, prefix = "Progress:", suffix = "Complete", length = 50)
	else:
		if os.path.exists("logs"):
			os.chdir("logs")
			filenames = os.listdir(".")
			result = []
			for filename in filenames:
				if os.path.isdir(os.path.join(os.path.abspath("."), filename)):
				result.append(filename)
			l = len(result)
			printProgressBar(0, l, prefix = "Progress:", suffix = "Complete", length = 50)
			for i, subdir in enumerate(result):
				for file in glob.glob("*MA_output_log.txt"):
					time_in_secs = time.time() - (days * 24 * 60 * 60)
					stat = os.stat(file)

					if stat.st_mtime <= time_in_secs:
						remove(file)
				time.sleep(0.1)
				printProgressBar(i + 1, l, prefix = "Progress:", suffix = "Complete", length = 50)
		else:
			print("Error! Logs folder not detected!")

def remround(days):
	if os.name == 'nt':
		os.chdir(os.getenv('APPDATA'))
		if os.path.exists("SCP Secret Laboratory"):
			os.chdir("SCP Secret Laboratory")
			os.chdir("ServerLogs")
			filenames = os.listdir(".")
			result = []
			for filename in filenames:
				if os.path.isdir(os.path.join(os.path.abspath("."), filename)):
					result.append(filename)
			l = len(result)
			printProgressBar(0, l, prefix = "Progress:", suffix = "Complete", length = 50)
			for i, subdir in enumerate(result):
				for file in glob.glob("*.txt"):
					time_in_secs = time.time() - (days * 24 * 60 * 60)
					stat = os.stat(file)
					if stat.st_mtime <= time_in_secs:
						remove(file)
				time.sleep(0.1)
				printProgressBar(i + 1, l, prefix = "Progress:", suffix = "Complete", length = 50)
	else:
		os.chdir(os.getenv('HOME'))
		os.chdir(".config/SCP Secret Laboratory/ServerLogs")
		filenames = os.listdir(".")
		result = []
		for filename in filenames:
			if os.path.isdir(os.path.join(os.path.abspath("."), filename)):
				result.append(filename)
		l = len(result)
		printProgressBar(0, l, prefix = "Progress:", suffix = "Complete", length = 50)
		for i, subdir in enumerate(result):
			for file in glob.glob("*.txt"):
				time_in_secs = time.time() - (days * 24 * 60 * 60)
				stat = os.stat(file)
				if stat.st_mtime <= time_in_secs:
					remove(file)
			time.sleep(0.1)
			printProgressBar(i + 1, l, prefix = "Progress", suffix = "Complete", length = 50)

def remat(days):
	if os.name == 'nt':
		os.chdir(os.getenv('APPDATA'))
		if os.path.exists("SCP Secret Laboratory"):
			os.chdir("SCP Secret Laboratory")
			if os.path.exists("AdminToolbox"):
				os.chdir("AdminToolbox\ServerLogs")
				filenames = os.listdir(".")
				result = []
				for filename in filenames:
					if os.path.isdir(os.path.join(os.path.abspath("."), filename)):
						result.append(filename)
				l = len(result)
				printProgressBar(0, l, prefix = "Progress:", suffix = "Complete", length = 50)
				for i, subdir in enumerate(result):
					for file in glob.glob("*.txt"):
						time_in_secs = time.time() - (days * 24 * 60 * 60)
						stat = os.stat(file)
						if stat.st_mtime <= time_in_secs:
							remove(file)
				time.sleep(0.1)
				printProgressBar(i + 1, l, prefix = "Progress:", suffix = "Complete", length = 50)
	else:
		os.chdir(os.getenv('HOME'))
		os.chdir(".config/SCP Secret Laboratory/AdminToolbox/ServerLogs")
		filenames = os.listdir(".")
		result = []
		for filename in filenames:
			if os.path.isdir(os.path.join(os.path.abspath("."), filename)):
				result.append(filename)
		l = len(result)
		printProgressBar(0, l, prefix = "Progress:", suffix = "Complete", length = 50)
		for i, subdir in enumerate(result):
			for file in glob.glob("*.txt"):
				time_in_secs = time.time() - (days * 24 * 60 * 60)
				stat = os.stat(file)
				if stat.st_mtime <= time_in_secs:
					remove(file)
			time.sleep(0.1)
			printProgressBar(i + 1, l, prefix = "Progress", suffix = "Complete", length = 50)

def main():
	clear()
	print("--Type 'A' to remove extraneous logkillers")
	print("--Type 'B' to remove old logfiles")
	print("--Type 'C' to exit")
	global choice 
	choice = str(input("Enter the key of your choice: "))
	if choice == "A":
		c2 = str(input("Remove SCP logkillers [y/n]? "))
		if c2 == "y": delscp()
		c3 = str(input("Remove MA logkillers [y/n]? "))
		if c3 == "y": delma()
		c4 = str(input("Remove Round logkillers [y/n]? "))
		if c4 == "y": delround()
		c5 = str(input("Remove AT logkillers [y/n]? "))
		if c5 == "y": delat()
	elif choice == "B":
		c_scp = str(input("Delete old SCP logfiles [y/n]? "))
		if c_scp == "y":
			idays = int(input("How long should the files be kept for? "))
			remscp(idays)
		c_ma = str(input("Delete old MA logfiles [y/n]? "))
		if c_ma == "y":
			idays = int(input("How long should the files be kept for? "))
			remma(idays)
		c_round = str(input("Delete old Round logfiles [y/n]? "))
		if c_round == "y":
			idays = int(input("How long should the files be kept for? "))
			remround(idays)
		c_at = str(input("Delete old AT logfiles (AdminToolbox - you may not have it installed)? "))
		if c_at == "y":
			idays = int(input("How long should the files be kept for? "))
			remat(idays)
	else:
		if choice != "C":
			print("Invalid option")
		else:
			print("Exiting...")

while True:
	main()
	if choice == "C" : break
