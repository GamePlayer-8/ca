@echo on

mkdir "C:\XaviaMaCert"
Invoke-WebRequest https://chimmie.k.vu/ca/ca/certificate.crt -O "C:\XaviaMaCert\ca.crt"
certutil -addstore "Root" "C:\XaviaMaCert\ca.crt"
del "C:\XaviaMaCert\ca.crt"
del "C:\XaviaMaCert"
