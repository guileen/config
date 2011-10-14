function FindProxyForURL(url, host) {
  var socks = "SOCKS5 127.0.0.1:8888";

  if (shExpMatch(host, "*google.com") ||
      shExpMatch(host, "*gmail.com") ||
      shExpMatch(host, "*wikipedia.com") ||
      shExpMatch(host, "*twitter.com") ||
      shExpMatch(host, "*craftyjs.com") ||
      shExpMatch(host, "*facebook.com")
      ) {
    return socks;
  }

  if (isInNet(host, "192.168.0.0", "10.0.0.0",  "255.0.0.0") ||
      isPlainHostName(host)){
    return "DIRECT";
  }

  //return "DIRECT; PROXY 192.168.1.1:3128; SOCKS5 lilinux.net:1080"; 
  return "DIRECT; " + socks;
}
