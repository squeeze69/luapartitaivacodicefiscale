-- include partitaiva.lua, NON va messa l'estensione
require("partitaiva")
-- CODICE DI TEST -- CODICE DI TEST
-- codice di test, considerare solo la funzione soprastante
testKO = {"xxxxxxxxxxx", "123456789012", "44444444444",
"12345678901", "44444+44440",
"corto", "123456789.3", "4444X444440", "1234567890x"
}
testOK = {"12345678903", "00000000000", "44444444440", ""}

print("--TEST: Risultato negativo (deve dare false)--")
print(string.format("numero=%s,%q",partitaiva(1234)))
print(string.format("booleano=%s,%q",partitaiva(true)))
for k,v in pairs(testKO) do
	print(string.format("%q=%s,%q",v,partitaiva(v)))
end

print("--TEST: Risultato positivo (deve dare true)--");
for k,v in pairs(testOK) do
	print(string.format("%q=%s,%q",v,partitaiva(v)))
end
