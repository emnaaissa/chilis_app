import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../models/banner.dart';
import '../services/banner_service.dart';

class BannerScreen extends StatefulWidget {
  @override
  _BannerScreenState createState() => _BannerScreenState();
}

class _BannerScreenState extends State<BannerScreen> {
  final BannerService bannerService = BannerService();
  late Future<List<AppBanner>> banners;
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  bool isActive = true;

  @override
  void initState() {
    super.initState();
    banners = bannerService.fetchBanners();
  }

  // Sélectionner une image depuis la galerie
  Future<void> _selectImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Créer une nouvelle bannière
  Future<void> _createBanner() async {
    if (_selectedImage != null) {
      try {
        final newBanner = await bannerService.createBanner(_selectedImage!, isActive);
        setState(() {
          banners = bannerService.fetchBanners();  // Mettre à jour la liste des bannières
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bannière créée avec succès!')));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la création: $e')));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez sélectionner une image')));
    }
  }

  // Supprimer une bannière
  Future<void> _deleteBanner(String id) async {
    try {
      await bannerService.deleteBanner(id);
      setState(() {
        banners = bannerService.fetchBanners();  // Mettre à jour la liste après suppression
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Bannière supprimée avec succès!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la suppression: $e')));
    }
  }

  // Modifier l'état de la bannière
  Future<void> _updateBannerState(String id, bool state) async {
    try {
      await bannerService.updateBannerState(id, state);  // Ajouter une méthode dans le service pour mettre à jour l'état
      setState(() {
        banners = bannerService.fetchBanners();  // Mettre à jour la liste après modification
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('État de la bannière mis à jour!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de la mise à jour: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestion des Bannières'),
        backgroundColor: Colors.redAccent,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder<List<AppBanner>>(
          future: banners,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Erreur: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('Aucune bannière disponible.'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final banner = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 5,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(12),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            banner.image,
                            fit: BoxFit.cover,
                            width: 80,
                            height: 80,
                          ),
                        ),
                        title: Text(
                          'Bannière ${banner.id}',  // Retirer l'affichage de l'ID
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              banner.etat ? 'Actif' : 'Inactif',
                              style: TextStyle(
                                color: banner.etat ? Colors.green : Colors.red,
                              ),
                            ),
                            Spacer(),
                            Switch(
                              value: banner.etat,
                              onChanged: (value) {
                                _updateBannerState(banner.id, value);
                              },
                              activeColor: Colors.green,
                              inactiveThumbColor: Colors.red,
                            ),
                          ],
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteBanner(banner.id),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _selectImage,
        child: Icon(Icons.add_a_photo),
        backgroundColor: Colors.redAccent,
        tooltip: 'Ajouter une image',
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: _createBanner,
          child: Text(
            "Créer la Bannière",
            style: TextStyle(fontSize: 16),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(vertical: 14),
          ),
        ),
      ),
    );
  }
}
