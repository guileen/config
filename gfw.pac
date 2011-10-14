var direct = 'DIRECT',
    http_proxy = 'proxy localhost:8888',
    socks = 'SOCKS5 127.0.0.1:8888',
    default = direct + '; ' + socks;

function FindProxyForURL(url, host) {

  if (host == 'raw.github.com') {
    alert('github');
    return direct;
  }

  if (shExpMatch(host, "*google.com") ||
      shExpMatch(host, "*gmail.com") ||
      shExpMatch(host, "*wikipedia.com") ||
      shExpMatch(host, "*twitter.com") ||
      shExpMatch(host, "*craftyjs.com") ||
      shExpMatch(host, "*facebook.com")
      ) {
    alert('socks');
    return socks;
  }

  if (isInNet(host, "192.168.0.0", "10.0.0.0",  "255.0.0.0") ||
      isPlainHostName(host)){
    alert('direct');
    return direct;
  }

  return default;
}
