
if @http_risco_vida_response_code == "200"  
      Rails.logger.info "AnatelConsumidor: BLOCO DE ABRIR O ARQUIVO" 
         a = JSON.parse(response_body)                
         filename = Dir.tmpdir + "/" + a["nome"] #nome do arquivo                
         data =  Base64.decode64(a["base64"]) #conteúdo do arquivo zip                
         File.open(filename, 'wb'){|f| f.write(data)}                
         Zip::File.open(filename) do |zip_file| 
         # Manipula cada arquivo do zip. Verificar a possibilidade de arq. unico                    
         zip_file.each do |entry|                    
         Rails.logger.info "AnatelConsumidor: Extraindo o arquivo de denúncias #{entry.name}"                    
         # Extrai para a memória. O arquivo está em ISO 8859-1                    
         # apesar do manual do serviço AC dizer que estaria em UTF-8                    
         content = entry.get_input_stream.read.force_encoding('ISO-8859-1')                    
         #parse do arquivo json, com conversão para UTF-8                    
         res = JSON.parse(content.encode("UTF-8"), symbolize_names: true)                    
         return res[:solicitacao]                    
        end                
    end            
end            
nil