import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:upstreet_flutter_code_challenge/resources/strings/routes.dart';
import 'package:upstreet_flutter_code_challenge/presentation/albums/bloc/albums_cubit.dart';
import 'package:upstreet_flutter_code_challenge/presentation/widgets/full_screen_loading.dart';
import 'package:upstreet_flutter_code_challenge/presentation/album_creation/bloc/album_creation_cubit.dart';
import 'package:upstreet_flutter_code_challenge/presentation/album_creation/bloc/album_creation_state.dart';
import 'package:upstreet_flutter_code_challenge/presentation/album_creation/album_creation_failed_page.dart';
import 'package:upstreet_flutter_code_challenge/presentation/album_creation/album_creation_in_process_page.dart';

class AlbumCreationPage extends StatelessWidget {
  const AlbumCreationPage({
    Key key,
    @required this.albumId,
    @required this.id,
  })  : assert(albumId != null),
        assert(id != null),
        super(key: key);

  final int albumId;
  final int id;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<AlbumCreationCubit, AlbumCreationState>(
          listenWhen: (previousState, currentState) =>
              previousState != currentState,
          listener: (_, state) => state.maybeWhen(
              created: () => _onCreated(context), orElse: () => null),
          child: BlocBuilder<AlbumCreationCubit, AlbumCreationState>(
            builder: (_, state) {
              return state.maybeWhen(
                loading: () => FullScreenLoading(),
                //TODO: Add action on failure state (e.g: try again creating album)
                failed: (failure) => AlbumCreationFailedPage(failure: failure),
                orElse: () =>
                    AlbumCreationInProcessPage(albumId: albumId, id: id),
              );
            },
          ),
        ),
      ),
    );
  }

  void _onCreated(BuildContext context) {
    Navigator.popAndPushNamed(context, Routes.albums_page);
    context.read<AlbumsCubit>().fetchAlbumPhotos();
  }
}
