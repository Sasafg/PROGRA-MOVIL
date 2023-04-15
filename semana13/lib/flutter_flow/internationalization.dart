import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['es', 'en'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? esText = '',
    String? enText = '',
  }) =>
      [esText, enText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // PAIS
  {
    '7oazxol6': {
      'es': 'Coloca un pais',
      'en': 'Place a country',
    },
    'utfx0fd7': {
      'es': 'AGREGAR',
      'en': 'ADD',
    },
    'bquo7sue': {
      'es': 'LIMPIAR LISTA',
      'en': 'CLEAN LIST',
    },
    '20fege1b': {
      'es': 'Light Mode',
      'en': '',
    },
    '89cd6v0i': {
      'es': 'Dark Mode',
      'en': '',
    },
    '2hxv1fjo': {
      'es': 'COLOR FAVORITO',
      'en': '',
    },
    '0mzantja': {
      'es': 'ESPERAR',
      'en': '',
    },
    'zxrrst73': {
      'es': 'Opcion 1',
      'en': 'Option 1',
    },
    '3mty9mjh': {
      'es': 'Ver Lista de paises',
      'en': 'See list of countries',
    },
    '7qk43pi3': {
      'es': 'Buscar...',
      'en': 'Look for...',
    },
    'db13ym9s': {
      'es': 'Paises',
      'en': 'countries',
    },
    '79wv1gmm': {
      'es': 'Inicio',
      'en': 'home',
    },
  },
  // Home
  {
    'dnknt9nw': {
      'es': 'AGREGAR UN NUEVO PAIS',
      'en': '',
    },
    '6m6orhmd': {
      'es': 'HOME',
      'en': '',
    },
    '314a69oy': {
      'es': 'Home',
      'en': '',
    },
  },
].reduce((a, b) => a..addAll(b));
