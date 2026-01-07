/// Application string constants
/// For non-localized strings (API keys, endpoints, etc.)
class AppStrings {
  AppStrings._();

  // App Info
  static const String appName = 'Flutter Core';
  static const String appVersion = '1.0.0';

  // API Endpoints (relative to base URL)
  static const String apiProducts = '/products';
  static const String apiProductDetail = '/products/{id}';
  static const String apiUpload = '/upload';
  static const String apiDownload = '/download';

  // Storage Keys (SharedPreferences/Secure Storage)
  static const String keyAuthToken = 'auth_token';
  static const String keyRefreshToken = 'refresh_token';
  static const String keyUserId = 'user_id';
  static const String keyThemeMode = 'theme_mode';
  static const String keyLanguage = 'language';
  static const String keyBiometricEnabled = 'biometric_enabled';
  static const String keyOnboardingCompleted = 'onboarding_completed';
  static const String keyLastSyncTime = 'last_sync_time';

  // Isar Collection Names
  static const String isarProducts = 'products';
  static const String isarFavorites = 'favorites';
  static const String isarSettings = 'settings';
  static const String isarSyncQueue = 'sync_queue';

  // Navigation Routes (defined in router)
  static const String routeHome = '/';
  static const String routeProducts = '/products';
  static const String routeProductDetail = '/products/:id';
  static const String routeProductAdd = '/products/add';
  static const String routeProductEdit = '/products/edit/:id';
  static const String routeFavorites = '/favorites';
  static const String routeProfile = '/profile';
  static const String routeSettings = '/settings';
  static const String routeLanguage = '/settings/language';
  static const String routeTheme = '/settings/theme';
  static const String routeBiometric = '/settings/biometric';

  // Date Formats
  static const String dateFormatShort = 'MMM dd, yyyy';
  static const String dateFormatLong = 'MMMM dd, yyyy';
  static const String dateFormatFull = 'EEEE, MMMM dd, yyyy';
  static const String timeFormat = 'hh:mm a';
  static const String dateTimeFormat = 'MMM dd, yyyy hh:mm a';

  // File Extensions
  static const List<String> imageExtensions = ['jpg', 'jpeg', 'png', 'gif', 'webp'];
  static const List<String> documentExtensions = ['pdf', 'doc', 'docx', 'txt'];
  static const List<String> videoExtensions = ['mp4', 'avi', 'mov'];

  // HTTP Headers
  static const String headerAuthorization = 'Authorization';
  static const String headerContentType = 'Content-Type';
  static const String headerAccept = 'Accept';
  static const String headerAcceptLanguage = 'Accept-Language';

  // Content Types
  static const String contentTypeJson = 'application/json';
  static const String contentTypeFormData = 'multipart/form-data';

  // Error Messages (Generic - UI messages use localization)
  static const String errorNetwork = 'Network error occurred';
  static const String errorUnknown = 'Unknown error occurred';
  static const String errorTimeout = 'Request timeout';
  static const String errorUnauthorized = 'Unauthorized access';
  static const String errorNotFound = 'Resource not found';
  static const String errorServer = 'Server error';

  // Validation Patterns
  static const String emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  static const String phonePattern = r'^\+?[\d\s\-\(\)]+$';
  static const String urlPattern = r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$';

  // Mock Data (Public API as fallback)
  static const String mockApiUrl = 'https://fakestoreapi.com';

  // Limits
  static const int maxImageUploadSize = 5 * 1024 * 1024; // 5MB
  static const int maxFileUploadSize = 10 * 1024 * 1024; // 10MB
  static const int maxImagesSelection = 5;
  static const int paginationLimit = 20;
  static const int searchDebounceMs = 500;

  // Biometric Messages
  static const String biometricReasonAuth = 'Authenticate to access the app';
  static const String biometricReasonConfirm = 'Confirm your identity';

  // Animation Durations (milliseconds)
  static const int animationFast = 150;
  static const int animationNormal = 300;
  static const int animationSlow = 500;
}

