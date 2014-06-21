CountUPer
=========

The very basic usage: ./countuper.pl http://target.host.tld/path/to

Advanced usage:
```
$ cat /var/log/apache2/access.log |./collect_uas.pl > uas_list.txt
$ ./countuper.pl -v -a uas_list.txt -m 5 -x 10 http://target.host.tld/path/to
```

Script collect_uas.pl is useful to get real User-Agent strings from web-server access.log. If you omit -a parameter of countuper.pl, it will use generic User-Agent string, the same for all requests.

Parameters -m and -x points to minimum and maximum period of seconds between the closest requests. This is used to randomize requests. If you omit them - all requests will go on each 5 seconds.

Parameter -v means verbose mode. If you omit it, script will be completely silent, unless error appears.
