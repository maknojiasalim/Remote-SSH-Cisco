#----------------------------------------------------------------------------
# Created By  : Salim Maknojia
# Created Date: 10/03/2022
# version ='1.0'
# Name = MultiOption.sh
# Python 2.7
# ---------------------------------------------------------------------------
# This Script will ping the host, if offline script ends, 
# if online it will SSH to the device and # will provide you the option 
# for command to run.
# Multi option can be use with numbers (space seperated) eg 1 3 4
# ---------------------------------------------------------------------------
import time, sys, getpass, paramiko, os, signal

# This will check if the Host is UP
ping_host = True
while ping_host:
        #ip = "XX.XX.XX.XX"
        ip = raw_input('Please enter the IP Address of the host: ')
	response = os.system("ping -D -O -c 5 " + ip)

        if response == 0:
            ping_host = False
            print ("Destination " + ip + " is UP" )
        else:
            ping_host = False
            print ("Destination " + ip + " is Down")
	    exit(0)
			
#Color the output
class bcolors:
    OK = '\033[92m' #GREEN
    WARNING = '\033[94m' #BLUE
    RESET = '\033[0m' #RESET COLOR
    FAIL = '\033[91m' #RED
	
# Option to select the username and password
# Due to using multiple username on different system i have created option for username 
#username = "admin"
#username = raw_input("Please enter username:")
#password = getpass.getpass('Please enter a password:')
while True:

	d1a = input("Username to use: 1 = XXXXX. 2 = admin. 3 = Others[1/2/3]? : ")
	if d1a == 1:
		username = "XXXXX"
		password = getpass.getpass('Please enter a password: ')
		break
	elif d1a == 2:
		username = "admin"
		password = "XXXXX"
		break
	elif d1a == 3:
		username = raw_input("Please enter username:")
		password = getpass.getpass('Please enter a password: ')
		break
	else:
		print (bcolors.FAIL + "========== This is not an option; Please try again. ==========" + bcolors.RESET)
	
# Lets try to SSH to the Host
#Create an instance of SSH Client
client = paramiko.SSHClient()
# Set the missing host key policy to auto add the certificate
client.set_missing_host_key_policy(paramiko.AutoAddPolicy())
client.connect(hostname=ip, username=username, password=password)
print("SSH session established with {0}\n".format(ip))
remote_conn = client.invoke_shell()
#remote_conn.send('\n')
os.system('clear')

#Seperator
sep = "="*75

commands = True
while commands:
	print "Select the command you want to run"
	print "1 = Show Interface Description"
	print "2 = Show Caller"
	print "3 = Show Version | include uptime"
	print "4 = Show clock"
	print "5 = Show Interface XXX"
	print "6 = Show Run Interface XXX"
	print "7 = Show IP BGP all summary"
	print "8 = Manual command"
	print "9 = Quit"
			
	cfchoose1 = map(int,raw_input("Input your Choice: ").split())
	# Change Terminal Length to 0
	remote_conn.send("term len 0\n")
	time.sleep(1)
	output = remote_conn.recv(50000)
	#Flush the output
	output = ""
	# # Getting Device basic info
	# remote_conn.send("sh ver | i upt|Last|Proc|System res|System imag\n")
	# output = remote_conn.recv(50000)
	# print output
	# print (bcolors.WARNING + sep + " END " + sep + bcolors.RESET)
	# time.sleep(1)
	
	for cfchoose in cfchoose1:
		time.sleep(1)
		if cfchoose == 1:
			remote_conn.send("show int desc\n")
			time.sleep(5)	
			output = remote_conn.recv(50000)
			print (bcolors.WARNING + sep + "=====" + sep + bcolors.RESET)
			print (bcolors.OK + output + bcolors.RESET)
			print (bcolors.WARNING + sep + " END " + sep + bcolors.RESET)
			time.sleep(1)
			#os.system('clear')
			#commands = True
				
		elif cfchoose == 2:
			remote_conn.send("show caller\n")
			time.sleep(1)
			output = remote_conn.recv(50000)
			print (bcolors.WARNING + sep + "=====" + sep + bcolors.RESET)
			print(bcolors.OK + output + bcolors.RESET)
			print (bcolors.WARNING + sep + " END " + sep + bcolors.RESET)
			#time.sleep(5)
			#os.system('clear')
			#commands = True
						
		elif cfchoose == 3:
			remote_conn.send("show ver | i upt\n")
			time.sleep(1)
			output = remote_conn.recv(50000)
			print (bcolors.WARNING + sep + "=====" + sep + bcolors.RESET)
			print (bcolors.OK + output + bcolors.RESET)
			print (bcolors.WARNING + sep + " END " + sep + bcolors.RESET)
			#time.sleep(5)
			#os.system('clear')
			#commands = True
				
		elif cfchoose == 4:
			remote_conn.send("show clock\n")
			time.sleep(1)
			output = remote_conn.recv(50000)
			print (bcolors.WARNING + sep + "=====" + sep + bcolors.RESET)
			print (bcolors.OK + output + bcolors.RESET)
			print (bcolors.WARNING + sep + " END " + sep + bcolors.RESET)
			#time.sleep(5)
			#os.system('clear')
			#commands = True
					
		elif cfchoose == 5:
			remote_conn.send("show int " + raw_input("Enter the Interface: ") + "\n")
			time.sleep(1)
			output = remote_conn.recv(50000)
			print (bcolors.WARNING + sep + "=====" + sep + bcolors.RESET)
			print (bcolors.OK + output + bcolors.RESET)
			print (bcolors.WARNING + sep + " END " + sep + bcolors.RESET)
			#time.sleep(5)
			#os.system('clear')
			#commands = True
					
		elif cfchoose == 6:
			remote_conn.send("show run int " + raw_input("Enter the Interface: ") + "\n")
			time.sleep(1)
			output = remote_conn.recv(50000)
			print (bcolors.WARNING + sep + "=====" + sep + bcolors.RESET)
			print (bcolors.OK + output + bcolors.RESET)
			print (bcolors.WARNING + sep + " END " + sep + bcolors.RESET)
			#time.sleep(5)
			#os.system('clear')
			#commands = True
						
		elif cfchoose == 7:
			remote_conn.send("show ip bgp all summary\n")
			time.sleep(1)
			output = remote_conn.recv(50000)
			print (bcolors.WARNING + sep + "=====" + sep + bcolors.RESET)
			print (bcolors.OK + output + bcolors.RESET)
			print (bcolors.WARNING + sep + " END " + sep + bcolors.RESET)
			#time.sleep(5)
			#os.system('clear')
			#commands = True
					
		elif cfchoose == 8:
			remote_conn.send(raw_input("Enter the Command: ") + "\n")
			time.sleep(1)
			output = remote_conn.recv(100000000)
			print (bcolors.WARNING + sep + "=====" + sep + bcolors.RESET)
			print (bcolors.OK + output + bcolors.RESET)
			print (bcolors.WARNING + sep + " END " + sep + bcolors.RESET)
			#time.sleep(5)
			#os.system('clear')
			#commands = True				
			
		elif cfchoose == 9:
			# Change Terminal Length to Default (30)
			remote_conn.send("term len 30\n")
			time.sleep(1)
			output = remote_conn.recv(500000)
			#Flush the output
			output = ""
			print (bcolors.FAIL + "========== Exiting the Script ==========" + bcolors.RESET)
			commands = False
			client.close()
		
		else:
			print (bcolors.FAIL + "========== This is not an option; Please try again. ==========" + bcolors.RESET)
 
