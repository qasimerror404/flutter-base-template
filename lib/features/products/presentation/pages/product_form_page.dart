import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_sizes.dart';
import '../../../../core/utils/extensions/context_extensions.dart';
import '../../../../core/utils/validators/validators.dart';
import '../../../../core/widgets/custom_button.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../domain/entities/product.dart';
import '../providers/product_providers.dart';

/// Product form page (add/edit)
class ProductFormPage extends ConsumerStatefulWidget {
  final String? productId;

  const ProductFormPage({
    super.key,
    this.productId,
  });

  @override
  ConsumerState<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends ConsumerState<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();
  final _categoryController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final product = Product(
      id: widget.productId ?? DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      description: _descriptionController.text,
      price: double.parse(_priceController.text),
      image: _imageController.text.isEmpty ? null : _imageController.text,
      category: _categoryController.text.isEmpty ? null : _categoryController.text,
    );

    try {
      if (widget.productId == null) {
        await ref.read(productsProvider.notifier).addProduct(product);
        if (mounted) {
          context.showSuccessSnackBar(context.l10n.productAdded);
        }
      } else {
        await ref.read(productsProvider.notifier).updateProduct(product);
        if (mounted) {
          context.showSuccessSnackBar(context.l10n.productUpdated);
        }
      }

      if (mounted) {
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        context.showErrorSnackBar(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.productId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? context.l10n.editProduct : context.l10n.addProduct),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSizes.p16),
          children: [
            CustomTextField(
              controller: _titleController,
              label: context.l10n.productName,
              validator: Validators.required,
            ),
            const SizedBox(height: AppSizes.p16),
            CustomTextField(
              controller: _descriptionController,
              label: context.l10n.productDescription,
              maxLines: 4,
              validator: Validators.required,
            ),
            const SizedBox(height: AppSizes.p16),
            CustomTextField(
              controller: _priceController,
              label: context.l10n.price,
              keyboardType: TextInputType.number,
              validator: Validators.compose([
                Validators.required,
                Validators.numeric,
              ]),
            ),
            const SizedBox(height: AppSizes.p16),
            CustomTextField(
              controller: _imageController,
              label: 'Image URL',
              keyboardType: TextInputType.url,
            ),
            const SizedBox(height: AppSizes.p16),
            CustomTextField(
              controller: _categoryController,
              label: 'Category',
            ),
            const SizedBox(height: AppSizes.p32),
            CustomButton(
              text: context.l10n.save,
              onPressed: _submit,
              isLoading: _isLoading,
            ),
          ],
        ),
      ),
    );
  }
}

