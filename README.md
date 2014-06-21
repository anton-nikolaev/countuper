CountUPer
=========

The very basic usage: ./countuper.pl http://target.host.tld/path/to

Advanced usage:
```
$ cat /var/log/apache2/access.log |./collect_uas.pl > uas_list.txt
$ ./countuper.pl -a uas_list.txt -m 5 -M 10 http://target.host.tld/path/to
```

Script collect_uas.pl is useful to get real User-Agent strings from web-server access.log. If you omit -a parameter of countuper.pl, it will use generic User-Agent string, the same for all requests.

Parameters -m and -M points to minimum and maximum period of seconds between the closest requests. This is used to randomize requests. If you omit them - all requests will go on each 5 seconds.
