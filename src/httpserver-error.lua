-- httpserver-error.lua
-- Handles sending error pages to client.

return function (connection, req, args)

   local function sendHeader(connection, code, errorString, extraHeaders, mimeType)
      connection:send("HTTP/1.0 " .. code .. " " .. errorString .. "\r\nServer: brainbox-httpserver\r\nContent-Type: " .. mimeType .. "\r\n")
      for i, header in ipairs(extraHeaders) do
         connection:send(header .. "\r\n")
      end 
      connection:send("connection: close\r\n\r\n")
   end

   print("Error " .. args.code .. ": " .. args.errorString)
   args.headers = args.headers or {}
   sendHeader(connection, args.code, args.errorString, args.headers, "text/html")
   connection:send("<html><head><title>" .. args.code .. " - " .. args.errorString .. "</title></head><body><h1>" .. args.code .. " - " .. args.errorString .. "</h1></body></html>\r\n")
end
