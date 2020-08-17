--[[
Verifica partita iva in LUA - versione 5.x o superiore (https://www.lua.org)
Versione: 1.0
Data: 10/12/2007
Autore: Marco Banfi
Licenza: LGPL
Porting basato sulle informazioni pubblicate da Umberto Salsi su Icosaedro:
sito web: http://www.icosaedro.it/cf-pi/index.html

uso, prendere la funzione "partitaiva"
Ingresso: la partita iva (come stringa)
Uscita: primo valore: true: va bene, false: non va bene (errori di vario tipo)
Uscita: secondo valore: un messaggio descrittivo più dettagliato, stringa vuota se va bene
NOTA BENE: In LUA, si può fare qualcosa come: r = partitaiva(partita) o r,m = partitaiva(partita), vanno bene entrambi
--]]
function partitaiva( p)
	if type(p) ~= "string" then
		return false,"non stringa"
	end
	if string.len(p) == 0 then
		return true,""
	end
	if string.len(p) ~= 11 then
		return false,"Lunghezza sbagliata"
	end
	local primo=0
	local secondo=0
	for i = 1,10,2 do
		local v = tonumber(string.sub(p,i,i))
		if v == nil then
			return false,"Carattere non valido"
		end
		primo = primo + v
		v = tonumber(string.sub(p,i+1,i+1))
		if v == nil then
			return false,"Carattere non valido"
		end
		secondo = 2 * v
		if secondo > 9 then
			secondo = secondo - 9
		end
		primo = primo + secondo
	end
	local check = tonumber(string.sub(p,11,11))
	if check == nil then
		return false,"Carattere non valido"
	end
	if (10-primo%10)%10 == check then
		return true,""
	end
	return false,"Non corrisponde il controllo"
end
