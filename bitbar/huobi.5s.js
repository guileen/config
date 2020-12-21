#!/usr/local/bin/node

var https= require('https')

render();

function render() {
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


function getMarket(callback) {
  https.get('https://api.huobi.pro/market/detail?symbol=btcusdt',{timeout:1000}, (resp) => {
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
