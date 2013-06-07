===============================
    Environment Setup
===============================

■　requirement

JDK/JRE 1.6
include JRF in the "PATH" environment variable

■　List of files

lib/
	Library folder
lib/ExchangeIODEF.jar
	the program file
Config.properties
  configuration file

===============================
    Usage
===============================

■　in case configuration file exists
java -jar lib/ExchangeIODEF.jar xmlFilePath

xmlFilePath: the XML file you wish to send

■　in case no configuration file exist
java -jar lib/ExchangeIODEF.jar -url parserURL xmlFilePath

parserURL: URL of the IODEF parser. identify until '/source'
    e.g., https://abc.com/IodefParser/source


===============================
    Configuration file
===============================

■  Name of the configuration file
Config.properties
This file name must not be changed

■  path to the configuration file
Current path (the path where this program was run)

■  configuration items
url = URL string
    e.g., url=http://abc.com/InformationSource/msg

prox y =Proxy's URL
    e.g., proxy=http://proxy.abc.com

<< for debugging >>
credential = the type of SSL authentication
    accept server certificate signed by itself
    e.g., credential=ALLOW_SELF_CREDENTIAL

