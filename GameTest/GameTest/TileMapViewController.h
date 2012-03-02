//module responsible for loading of map
//NOTE: tileNumber IS 1 based numbering instead of 0 based

@interface TileMapViewController : UIViewController

@property (nonatomic, readonly, strong) NSString *mapName;
@property (nonatomic, readonly) CGFloat width;
@property (nonatomic, readonly) CGFloat height;
@property (nonatomic, readonly) int numRows;
@property (nonatomic, readonly) int numCols;
@property (nonatomic, readonly, strong) NSArray *wayPoints;
@property (nonatomic, readonly, strong) NSArray *canBuild; //boolean array

@property (nonatomic, readonly) CGFloat tileWidth;
@property (nonatomic, readonly) CGFloat tileHeight;

- (id)initFromFile:(NSString *)fileName;

- (CGPoint)centerOfTile:(int)tileNumber;
- (CGPoint)originOfTile:(int)tileNumber;
- (BOOL)canBuildOnTile:(int)tileNumber;

@end
