import requests
def pretty_print_POST(req):
	print('{}\n{}\r\n{}\r\n\r\n{}'.format(
        '-----------START-----------',
        req.method + ' ' + req.url,
        '\r\n'.join('{}: {}'.format(k, v) for k, v in req.headers.items()),
        req.body,
    ))

r= requests.put('https://squadronirsc.firebaseio.com/status.json', json={"code":'10'})
print(pretty_print_POST(r.request))