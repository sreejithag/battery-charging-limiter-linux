# battery-manager-linux

Helps to set max battery charging threshold to protect battery health
When laptop is being used constaly with charger plugged in it is better to limit the charging at 60% to 80% to improve the battery health.
Many laptop vendors like Asus provides software utility to set the battery max charge threshold but it works only in windows.

With Linux kernal 5.4 added the ability to set a battery charge threshold for many Asus laptops.

This script can be used to set a max bettrey charge thrsehold.

Run th script limit.sh with max battery threshold as argument

`eg: ./limit.sh 60`

Will set the battery threshold to 60% so even if laptop is pulgged in it won't charge beyond 60% helps to protect the abttery health.

Tested in Asus laptop with AMD Ryzen 3500U running Linux mint 20 Linux Kernal  5.8.0-25-generic 

 
