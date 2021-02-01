#!/usr/local/bin/node

var http= require('http')

render();

var s =  "▁▂▃▄▅▆▇█"

function render() {
  /*
  getKline((msg, err)=>{
    if (err) {
      console.log(err)
    } else {
      // console.log(msg)
    }
  })
  */
  getMarket((msg, err)=>{
    if(err) {
      console.log('err')
    } else {
      console.log('$' + Math.round(msg.tick.close))
      console.log('---')
      console.log('Open:' + msg.tick.open)
      console.log('High:' + msg.tick.high)
      console.log('Low:' + msg.tick.low)
    }
  })
}

function getJSON(url, callback) {
  http.get(url,{timeout:1000}, (resp) => {
      var data = '';
      resp.on('data', (chunk) => {
        data += chunk;
      });
  
      resp.on('end', () => {
        try{
          var response = JSON.parse(data);
          callback(response)
        }catch(error){
          callback(null, err)
        }
      });
  
    }).on("error", (err) => {
        callback(null, err);
    });
}

function getMarket(callback) {
  getJSON('http://ipub.io/huobi/market/detail?symbol=btcusdt', callback);
}

function getKline(callback) {
  getJSON('http://ipub.io/huobi/market/history/kline?symbol=btcusdt&period=15min&size=6', callback);
}
