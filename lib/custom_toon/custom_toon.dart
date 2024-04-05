generalHeader(headers) {
  headers["Authorization"] = 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJpYXQiOjE3MTExOTExODQsImp0aSI6Ik9ETmpNMkUyWlRZdE16QmhNeTAwTnpGaExUaG1aall0TldGbFpqQTNPV1l3TmpaaCIsImlzcyI6InN1cGVyYXBwIiwibmJmIjoxNzExMTkxMTg0LCJleHAiOjE3MTExOTE3ODQsInZhbHVlcyI6eyJ1c2VybmFtZSI6ImFya29tckBnbWFpbC5jb20iLCJ1c2VyaWQiOiIzIiwicGFyZW50dXNlcmlkIjoiIiwidXNlcmxldmVsIjotMSwidXNlcnByaW1hcnlrZXkiOiIzIiwicGVybWlzc2lvbiI6MH19.QCvFSaUiTWWs6peiAaMxNmzYM6PqlPKspKqnutG6G0G4E28tw2kJouktHBj3t-5B1Zo9KxhA7VIq0EZBya25Ig';
  headers["Os"] = 'Android';
  headers["App-Version"] = '1.0';
  headers["Os-Version"] = '3.0';
  headers["Lang"] = 'en';

  //headers["Accept"] = 'application/json';
  //headers["Content-Type"] = 'application/json';

  //headers["Access-Control-Allow-Origin"] = '*';
  //headers["Content-Type"] = 'application/json';

  //headers["Accept"] = '*/*';
  /*headers["User-Agent"] = 'PostmanRuntime/7.37.0';
  headers["Accept-Encoding"] = 'gzip, deflate, br';
  headers["Connection"] = 'keep-alive';*/

  return headers;
}