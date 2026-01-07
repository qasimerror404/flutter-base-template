// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'فلاتر كور';

  @override
  String get welcome => 'مرحباً';

  @override
  String get home => 'الرئيسية';

  @override
  String get products => 'المنتجات';

  @override
  String get favorites => 'المفضلة';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get settings => 'الإعدادات';

  @override
  String get theme => 'المظهر';

  @override
  String get language => 'اللغة';

  @override
  String get light => 'فاتح';

  @override
  String get dark => 'داكن';

  @override
  String get system => 'النظام';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get version => 'الإصدار';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirm => 'تأكيد';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get search => 'بحث';

  @override
  String get noInternetConnection => 'لا يوجد اتصال بالإنترنت';

  @override
  String get addProduct => 'إضافة منتج';

  @override
  String get editProduct => 'تعديل المنتج';

  @override
  String get deleteProduct => 'حذف المنتج';

  @override
  String get deleteProductConfirmation => 'هل أنت متأكد من حذف هذا المنتج؟';

  @override
  String get productName => 'اسم المنتج';

  @override
  String get productDescription => 'وصف المنتج';

  @override
  String get price => 'السعر';

  @override
  String get productAdded => 'تم إضافة المنتج';

  @override
  String get productUpdated => 'تم تحديث المنتج';

  @override
  String get productDeleted => 'تم حذف المنتج';

  @override
  String get noProducts => 'لا توجد منتجات';

  @override
  String get noProductsDescription =>
      'لم يتم العثور على منتجات. أضف منتجاً جديداً للبدء.';

  @override
  String get noFavorites => 'لا توجد مفضلات';

  @override
  String get noFavoritesDescription => 'لم تقم بإضافة أي مفضلات بعد.';

  @override
  String get biometricAuthentication => 'المصادقة البيومترية';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get isRequired => 'مطلوب';

  @override
  String get invalidEmail => 'الرجاء إدخال عنوان بريد إلكتروني صحيح';

  @override
  String get invalidPhone => 'الرجاء إدخال رقم هاتف صحيح';

  @override
  String get invalidUrl => 'الرجاء إدخال رابط صحيح';

  @override
  String minLengthError(int length) {
    return 'يجب أن يكون $length أحرف على الأقل';
  }

  @override
  String maxLengthError(int length) {
    return 'يجب ألا يتجاوز $length حرفاً';
  }

  @override
  String get passwordMinLength => 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';

  @override
  String get passwordUppercase =>
      'يجب أن تحتوي كلمة المرور على حرف كبير واحد على الأقل';

  @override
  String get passwordLowercase =>
      'يجب أن تحتوي كلمة المرور على حرف صغير واحد على الأقل';

  @override
  String get passwordDigit => 'يجب أن تحتوي كلمة المرور على رقم واحد على الأقل';

  @override
  String get passwordSpecialChar =>
      'يجب أن تحتوي كلمة المرور على رمز خاص واحد على الأقل';

  @override
  String get passwordsDoNotMatch => 'كلمات المرور غير متطابقة';

  @override
  String get invalidNumber => 'الرجاء إدخال رقم صحيح';

  @override
  String minValueError(num min) {
    return 'القيمة يجب أن تكون $min على الأقل';
  }

  @override
  String maxValueError(num max) {
    return 'القيمة يجب ألا تتجاوز $max';
  }

  @override
  String rangeError(num min, num max) {
    return 'القيمة يجب أن تكون بين $min و $max';
  }
}
