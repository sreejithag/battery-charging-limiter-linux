# battery-manager-linux

When the laptop is being constantly used with a charger plugged in it is better to limit the charging at 60% to 80% to improve the battery health.
Many laptop vendors like Asus provide software utility to set the battery max charge threshold but it works only in windows.

With Linux kernel 5.4 added the ability to set a battery charge threshold for many Asus laptops this script uses it to set the limit.

## Usage
Run the script limit.sh with max battery threshold as an argument

`eg: ./limit.sh 60`

*prompt to enter the password since it needs sudo permission*\

Will set the battery threshold to 60% so even if the laptop is plugged in it won't charge beyond 60% helps to protect the battery health.


### More info
* [ASUS Battery Information Center](https://www.asus.com/support/FAQ/1038475/)
* [Arch Wiki](https://www.asus.com/support/FAQ/1038475/)


-----
>Tested in Asus laptop with AMD Ryzen 3500U running Linux mint 20 Linux Kernal  5.8.0-25-generic 
