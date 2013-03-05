var direct = 'DIRECT',
    http_proxy = 'proxy localhost:8888',
    socks = 'SOCKS5 127.0.0.1:8888',
    all = direct + '; ' + socks;

function FindProxyForURL(url, host) {

  if (host == 'raw.github.com') {
    alert('github direct ' + url);
    return direct;
  }

  if (shExpMatch(host, "*google.com") ||
      shExpMatch(host, "*gmail.com") ||
      shExpMatch(host, "*adobe.com") ||
      shExpMatch(host, "*wikipedia.com") ||
      shExpMatch(url, "*blogspot.com*") ||
      shExpMatch(url, "*wordpress.com*") ||
      shExpMatch(host, "*twitter.com") ||
      shExpMatch(host, "*youtube.com") ||
      shExpMatch(host, "*ytimg.com") ||
      // dev site
      shExpMatch(host, "*craftyjs.com") ||
      shExpMatch(host, "*lesscss.org") ||
      shExpMatch(host, "*tumblr.com") ||
      // facebook
      shExpMatch(host, "*facebook.com")
      ) {
    alert('socks ' + url);
    return socks;
  }

  if (isInNet(host, "192.168.0.0", "10.0.0.0",  "255.0.0.0") ||
      isPlainHostName(host)){
    alert('direct ' + url);
    return direct;
  }

  return all;
}
