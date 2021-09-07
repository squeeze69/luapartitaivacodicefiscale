--[[
Verifica codice fiscale in LUA  - versione 5.x o superiore (https://www.lua.org)
Versione: 1.0
Data: 10/12/2007
Autore: Marco Banfi
Licenza: LGPL
Porting basato sulle informazioni pubblicate da Umberto Salsi su Icosaedro:
sito web: http://www.icosaedro.it/cf-pi/index.html

funzione codicefiscale
ingresso: codice fiscale come stringa
uscita: ritorna due valori
primo: true: a posto, false: non va bene
secondo: la specifica di quale errore c'è stato ("" se non ve ne sono stati)

NOTA BENE: In LUA, si può fare qualcosa come: r = codicefiscale(cf) o r,m = codicefiscale(cf), vanno bene entrambi
--]]
function codicefiscale(cfin)
	if type(cfin) ~= "string" then
		return false,"Non stringa"
	end
	if string.len(cfin) == 0 then
		return true,""
	end
	if string.len(cfin) ~= 16 then
		return false,"Lunghezza sbagliata"
	end
	-- string.upper dovrebbe andare da lua 5.0 in su
	cfin = string.upper(cfin)

	-- decodifica caratteri codice fiscale
	local tcf ={["0"]=1, ["1"]=0, ["2"]=5, ["3"]=7, ["4"]=9, ["5"]=13, ["6"]=15, ["7"]=17, ["8"]=19,
		["9"]=21, ["A"]=1, ["B"]=0, ["C"]=5, ["D"]=7, ["E"]=9, ["F"]=13, ["G"]=15, ["H"]=17,
		["I"]=19, ["J"]=21, ["K"]=2, ["L"]=4, ["M"]=18, ["N"]=20, ["O"]=11, ["P"]=3, ["Q"]=6, ["R"]=8,
		["S"]=12, ["T"]=14, ["U"]=16, ["V"]=10, ["W"]=22, ["X"]=25, ["Y"]=24, ["Z"]=23
	}

	-- table per simulare "ord" di altri linguaggi
	local ordv ={["0"]=0, ["1"]=1, ["2"]=2, ["3"]=3, ["4"]=4, ["5"]=5, ["6"]=6, ["7"]=7, ["8"]=8, ["9"]=9,
		["A"]=0, ["B"]=1, ["C"]=2, ["D"]=3, ["E"]=4, ["F"]=5, ["G"]=6, ["H"]=7, ["I"]=8, ["J"]=9,
		["K"]=10, ["L"]=11, ["M"]=12, ["N"]=13, ["O"]=14, ["P"]=15, ["Q"]=16, ["R"]=17, ["S"]=18,
		["T"]=19, ["U"]=20, ["V"]=21, ["W"]=22, ["X"]=23, ["Y"]=24, ["Z"]=25
	}

	-- inizializza s con il 15 esimo carattere
	local s = tcf[string.sub(cfin,15,15)]
	if s==nil then
		return false,"Carattere non accettabile"
	end
	for i=1,13,2 do
		local v = tcf[string.sub(cfin,i,i)]
		if v == nil then
			return false,"Carattere non accettabile"
		end
		local o = ordv[string.sub(cfin,i+1,i+1)]
		if o == nil then
			return false,"Carattere non accettabile"
		end
		s = s + v + o
	end
	local controllo = ordv[string.sub(cfin,16,16)]
	if controllo == nil then
		return false,"Carattere non accettabile"
	end
	if s%26 ~= controllo then
		return false,"Carattere di controllo non valido"
	end
	return true,""
end
