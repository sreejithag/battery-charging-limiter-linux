# Battery Charging limiter Linux (ASUS Laptops)

When the laptop is being constantly used with a charger plugged in it is better to limit the charging at 60% to 80% to improve the battery health.
Many laptop vendors like Asus provide software utility to set the battery max charge threshold but it works only in windows.

With Linux kernel 5.4 added the ability to set a battery charge threshold for many Asus laptops this script uses it to set the limit.

## Usage
Run the script limit.sh with max battery threshold as an argument

`eg: ./limit.sh 60`

*prompt to enter the password since it needs sudo permission*

Will set the battery threshold to 60% so even if the laptop is plugged in it won't charge beyond 60% helps to protect the battery health.

*limit.sh set limit won't persist on system reboot*

or 

For operating systems with systemd  use other script limitd.sh that will create a systemd service to apply the limit on system reboot.

`eg: ./limitd.sh 60`


Reboot the system and check if limit works

#### Renable full capacity 

Run the limit.sh script with 100%

`./limit.sh 100`

or

`./limitd.sh 100 `

This will persist the change on reboot if sytemd is available 

Note: make the script executable before running by executing 
`chmod +x limit.sh`


## More info
* [ASUS Battery Information Center](https://www.asus.com/support/FAQ/1038475/)
* [Arch Wiki](https://wiki.archlinux.org/index.php/Laptop/ASUS#Battery_charge_threshold)


-----
>Tested in Asus vivobook 15 with AMD Ryzen 3500U running Linux mint 20 Kernal 5.8.0-25-generic 
