#import "TileMapViewController.h"

@implementation TileMapViewController

@synthesize mapName;
@synthesize width;
@synthesize height;
@synthesize numRows;
@synthesize numCols;
@synthesize wayPoints;
@synthesize canBuild;

@synthesize tileWidth;
@synthesize tileHeight;

- (id)initFromFile:(NSString *)fileName
{
    //Requires: fileName MUST NOT HAVE postfix @".plist"
    //Effect: initialise map of a level according to data in the corresponding file
    self = [super init];
    if (self == nil) {
        NSLog(@"malloc error loading map");
        return nil;
    }
    //load data from file
    NSString *bundle = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"]; 
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:bundle];
    NSString *errorDesc = nil;
    NSPropertyListFormat format;
    NSDictionary *mapInfo = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML mutabilityOption:NSPropertyListMutableContainersAndLeaves format:&format errorDescription:&errorDesc];
    if (!mapInfo)
        NSLog(@"Error reading plist: %@, format: %d", errorDesc, format);
    
    //load keys into properties
    mapName = [mapInfo objectForKey:@"mapName"];
    width = [[mapInfo objectForKey:@"width"] doubleValue];
    height = [[mapInfo objectForKey:@"height"] doubleValue];
    numRows = [[mapInfo objectForKey:@"numRows"] intValue];
    numCols = [[mapInfo objectForKey:@"numColumns"] intValue];
    tileWidth = width/numRows;
    tileHeight = height/numCols;
    
    wayPoints = [mapInfo objectForKey:@"wayPoints"];
    
    NSMutableArray *temp = [NSMutableArray array];
    for(int i=0;i<numRows*numCols;i++)
        [temp addObject:[NSNumber numberWithBool:YES]];
    
    
    return self;
}

- (CGPoint) originOfTile:(int)tileNumber
{
    int row = tileNumber/numRows;
    int col = (tileNumber-1)%numRows;
    return CGPointMake(row*tileHeight, col*tileWidth);
}

- (CGPoint) centerOfTile:(int)tileNumber
{
    CGPoint temp = [self originOfTile:tileNumber];
    return CGPointMake(temp.x+tileWidth/2, temp.y+tileHeight/2);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
    UIImage *mapImage = [UIImage imageNamed:mapName];
    UIImageView *map = [[UIImageView alloc] initWithImage:mapImage];
    [map setUserInteractionEnabled:YES];
    map.frame = CGRectMake(0, 0, width, height);
    self.view = map;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
