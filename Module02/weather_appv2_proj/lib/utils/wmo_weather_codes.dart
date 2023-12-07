class WmoWeatherCodes {

  static Map<int, String> wmoCodes = {
    0: "Clear sky",
    1: "Mainly clear",
    2: "Partly cloudy",
    3: "Overcast",
    45: "Fog",
    48: "Depositing rime fog",
    51: "Drizzle light",
    53: "Drizzle moderate",
    55: "Drizzle dense",
    56: "Freezing Drizzle light",
    57: "Freezing Drizzle dense",
    61: "Rain slight",
    63: "Rain moderate",
    65: "Rain intensity",
  };

  static String getSkyFromCode(int code) {
    return wmoCodes[code] ?? "No data";
  }
}