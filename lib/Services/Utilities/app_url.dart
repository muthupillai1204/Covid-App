//jitni bhi api use karenge yaaha par define karenge(directly call and define)
class AppUrl {
//this is our base url
  static String baseUrl = "https://disease.sh/v3/covid-19/";

//fetch world covid states
  static String worldStatesApi = '${baseUrl}all';
  static String countriesList = '${baseUrl}countries';
}
