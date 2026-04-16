class ApiEndpoints {
  // Base URL
  static const String baseUrl =
      'https://trigo-server-production.up.railway.app';

  // ── Auth ──────────────────────────────────────────────────────────────────
  static const String registerEndpoint = '/api/v1/auth/register';
  static const String verifyOtpEndpoint = '/api/v1/auth/verify-otp';
  static const String loginEndpoint = '/api/v1/auth/login';
  static const String profileEndpoint = '/api/v1/profile';

  // ── Payment ───────────────────────────────────────────────────────────────
  static const String paymentMethodsEndpoint = '/api/v1/payment-methods';

  // ── Saved Places ──────────────────────────────────────────────────────────
  /// GET  — fetch user's frequent/saved locations
  /// POST — save a new place with icon
  static const String savedPlacesEndpoint = '/api/v1/saved-places';

  // ── Pricing ───────────────────────────────────────────────────────────────
  /// GET — fetch available currency exchange rates
  static const String exchangeRatesEndpoint = '/api/v1/pricing/exchange-rates';

  /// POST — calculate final price for a given currency
  /// Body: { currency, pickup, dropoff, stops[] }
  static const String priceCalculateEndpoint = '/api/v1/pricing/calculate';

  // ── Drivers ───────────────────────────────────────────────────────────────
  /// GET /drivers/:userId — fetch driver profile (includes vehicleId).
  static const String driversEndpoint = '/api/v1/drivers/';

  // ── Trips ─────────────────────────────────────────────────────────────────
  /// POST — create a new trip
  /// Body: { tripType: "PRIVATE", structureType: "MULTI_STOP"|"SINGLE", ... }
  static const String tripsEndpoint = '/api/v1/trips';

  /// GET /trips/:id — real-time trip details, poll every 3s for status changes
  static const String tripDetailEndpoint = '/api/v1/trips/';

  /// POST /trips/:id/cancel — cancel an active or pending trip
  static const String tripCancelSuffix = '/cancel';

  /// POST /trips/:id/stops/:stopId/arrival — driver arrived at stop, starts wait timer
  static const String stopArrivalSuffix = '/stops/';

  /// suffix appended after stopId for both arrival and departure
  static const String stopArrivalAction = '/arrival';
  static const String stopDepartureAction = '/departure';

  // ── Ratings ───────────────────────────────────────────────────────────────
  /// GET — fetch available rating tags shown post-trip
  static const String ratingOptionsEndpoint = '/api/v1/ratings/options';

  /// POST — submit star rating + selected tag IDs
  static const String submitRatingEndpoint = '/api/v1/ratings';

  // ── Locations ─────────────────────────────────────────────────────────────
  static const String nearbyLocationsEndpoint = '/api/v1/locations/nearby';
  static const String searchLocationsEndpoint = '/api/v1/locations/search';

  // ── Matching ──────────────────────────────────────────────────────────────
  static const String nearbyDriversEndpoint = '/api/v1/matching/nearby';

  // ── Coverage ──────────────────────────────────────────────────────────────
  static const String coverageCheckEndpoint = '/api/v1/coverage/check';

  // ── Headers ───────────────────────────────────────────────────────────────
  static const String contentTypeHeader = 'Content-Type';
  static const String acceptHeader = 'Accept';
  static const String authorizationHeader = 'Authorization';
  static const String applicationJson = 'application/json';
}
