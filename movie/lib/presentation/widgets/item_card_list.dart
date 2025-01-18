import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/urls.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/movie.dart';
import '../pages/movie_detail_page.dart';

class ItemCard extends StatefulWidget {
  final Movie movie;

  const ItemCard({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  _ItemCardState createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  // Crear un FocusNode para manejar el enfoque
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: _focusNode,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            MovieDetailPage.routeName,
            arguments: widget.movie.id,
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 255, 0, 0),
            borderRadius: BorderRadius.circular(10.0),
            
          ),
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: CachedNetworkImage(
                    imageUrl: Urls.imageUrl(widget.movie.posterPath!),
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                flex: 3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie.title ?? '-',
                      overflow: TextOverflow.ellipsis,
                      style: kHeading6,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 4.0),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 2.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.redAccent,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: Text(widget.movie.releaseDate!.split('-')[0]),
                        ),
                        const SizedBox(width: 16.0),
                        const Icon(
                          Icons.star,
                          color: Colors.amber,
                          size: 18.0,
                        ),
                        const SizedBox(width: 4.0),
                        Text(
                          (widget.movie.voteAverage! / 2).toStringAsFixed(1),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      widget.movie.overview ?? '-',
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
