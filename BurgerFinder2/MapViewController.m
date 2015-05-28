//
//  MapViewController.m
//  TopPics
//
//  Created by Stephen Astels on 12-08-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MapViewController.h"
#import "MapKit/MapKit.h"
#import "MapViewAnnotation.h"

@interface MapViewController () <MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@end

@implementation MapViewController 

@synthesize mapView = _mapView;
@synthesize annotations = _annotations;
@synthesize delegate = _delegate;

// ---------------------------------------------------------------------
// ---------------------------------------------------------------------
#pragma mark - Getters / Setters

-(void)setMapView:(MKMapView *)mapView
{
    _mapView = mapView;
    [self updateMapView];
}

-(void)setAnnotations:(NSArray *)annotations
{
    _annotations = annotations;
    [self updateMapView];
}
// ---------------------------------------------------------------------

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.annotations = [self restaurantAnnotations];
    self.mapView.delegate = self;
}

// ---------------------------------------------------------------------

-(NSArray*) restaurantAnnotations
{
    NSMutableArray *annotations = [[NSMutableArray alloc] init];
    MapViewAnnotation *annotation = [[MapViewAnnotation alloc] init];
    annotation.annotationTitle = @"Westboro";
    annotation.annotationCoordinate = CLLocationCoordinate2DMake(45.39225, -75.75328);
    [annotations addObject:annotation];
    annotation = [[MapViewAnnotation alloc] init];
    annotation.annotationTitle = @"The Glebe";
    annotation.annotationCoordinate = CLLocationCoordinate2DMake(45.40804, -75.69138);
    [annotations addObject:annotation];
    annotation = [[MapViewAnnotation alloc] init];
    annotation.annotationTitle = @"Hunt Club";
    annotation.annotationCoordinate = CLLocationCoordinate2DMake(45.35408, -75.64335);
    [annotations addObject:annotation];
    annotation = [[MapViewAnnotation alloc] init];
    annotation.annotationTitle = @"Barrhaven";
    annotation.annotationCoordinate = CLLocationCoordinate2DMake(45.29367, -75.74305);
    [annotations addObject:annotation];
    annotation = [[MapViewAnnotation alloc] init];
    annotation.annotationTitle = @"Kanata";
    annotation.annotationCoordinate = CLLocationCoordinate2DMake(45.29189, -75.85729);
    [annotations addObject:annotation];
    annotation = [[MapViewAnnotation alloc] init];
    annotation.annotationTitle = @"Orleans";
    annotation.annotationCoordinate = CLLocationCoordinate2DMake(45.48185, -75.47408);
    [annotations addObject:annotation];
    annotation = [[MapViewAnnotation alloc] init];
    annotation.annotationTitle = @"Manor Park";
    annotation.annotationCoordinate = CLLocationCoordinate2DMake(45.44885, -75.65106);
    [annotations addObject:annotation];
    
    return annotations;
}

// ---------------------------------------------------------------------

-(void) updateMapView
{
    if (self.mapView.annotations)
        [self.mapView removeAnnotations:self.mapView.annotations];
    if (self.annotations)
        [self.mapView addAnnotations:self.annotations];
    [self recenterMap];
}

// ---------------------------------------------------------------------

- (void)recenterMap {
    NSArray *coordinates = [self.mapView valueForKeyPath:@"annotations.coordinate"];
    if ([coordinates count] > 0) {
        CLLocationCoordinate2D maxCoord = {-90.0f, -180.0f};
        CLLocationCoordinate2D minCoord = {90.0f, 180.0f};
        
        for(NSValue *value in coordinates) {
            CLLocationCoordinate2D coord = {0.0f, 0.0f};
            [value getValue:&coord];
            minCoord.latitude = MIN(minCoord.latitude, coord.latitude);
            minCoord.longitude = MIN(minCoord.longitude, coord.longitude);
            maxCoord.latitude = MAX(maxCoord.latitude, coord.latitude);
            maxCoord.longitude = MAX(maxCoord.longitude, coord.longitude);
        }
        MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
        region.center.latitude = (minCoord.latitude + maxCoord.latitude) / 2.0;
        region.center.longitude = (minCoord.longitude + maxCoord.longitude) / 2.0;
        region.span.latitudeDelta = 1.1 * (maxCoord.latitude - minCoord.latitude);
        region.span.longitudeDelta = 1.1 * (maxCoord.longitude - minCoord.longitude);
        [self.mapView setRegion:region animated:YES];  
    }
}

// ---------------------------------------------------------------------
// ---------------------------------------------------------------------
#pragma mark - MapView delegate

- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    if (annotation == mapView.userLocation)
        return nil;
    else {
        MKAnnotationView *aView = [mapView dequeueReusableAnnotationViewWithIdentifier:@"MapVC"];
        if (!aView) {
            aView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"MapVC"];
            aView.canShowCallout = YES;
//            aView.leftCalloutAccessoryView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        }
        aView.annotation = annotation;
//        [(UIImageView*)aView.leftCalloutAccessoryView setImage:nil];
        //    aView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        return aView;
    }
}

// ---------------------------------------------------------------------

- (void) mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    /*
    dispatch_queue_t downloadQueue = dispatch_queue_create("flickr downloader", NULL);
    dispatch_async(downloadQueue, ^{
        UIImage *image = [self.delegate mapViewController:self imageForAnnotation:view.annotation];
        dispatch_async(dispatch_get_main_queue(), ^{
            [(UIImageView*)view.leftCalloutAccessoryView setImage:image];
        });
    });
    dispatch_release(downloadQueue);
*/
}

/*
- (void) mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    NSLog(@"tapped a callout!");
    NSDictionary *metaData = ((TopPicsAnnotation*)view.annotation).metaData;
    if ([metaData objectForKey:FLICKR_PLACE_NAME] != Nil)
        [self performSegueWithIdentifier:@"MapToList" sender:view];
    else {
        ViewPicViewController *detail = [self.splitViewController.viewControllers lastObject];
        if (detail) {
            [detail setPhotoMetaData:metaData];
            [ManageRecents addToRecents:metaData];
        } else
            [self performSegueWithIdentifier:@"MapToViewPic" sender:view];
    }
}
  */


// ---------------------------------------------------------------------
// ---------------------------------------------------------------------
#pragma mark - Standard Methods
/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(MKAnnotationView*)sender
{   
    NSLog(@"Segue: %@", segue.identifier);
    NSDictionary *metaData = ((TopPicsAnnotation*)sender.annotation).metaData;
    if ([segue.identifier isEqualToString:@"MapToList"]) {
        [ segue.destinationViewController setSeguedTo:YES];
        [segue.destinationViewController setTitle: [FlickrPlaceNameParser CityForPlace:metaData]];
        [ segue.destinationViewController setPhotos:Nil];
        dispatch_queue_t downloadQueue = dispatch_queue_create("flickr downloader", NULL);
        dispatch_async(downloadQueue, ^{
            NSArray *photosInPlace = [FlickrFetcher photosInPlace:metaData maxResults:20];
            dispatch_async(dispatch_get_main_queue(), ^{
                [ segue.destinationViewController setPhotos:photosInPlace];
            });
        });
        dispatch_release(downloadQueue);
    } 
    else {
        [ManageRecents addToRecents:metaData];
        [segue.destinationViewController setPhotoMetaData:metaData];
    }
}
*/
// ---------------------------------------------------------------------


// ---------------------------------------------------------------------

- (void)viewDidUnload
{
    [self setMapView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

// ---------------------------------------------------------------------

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

// ---------------------------------------------------------------------
// ---------------------------------------------------------------------
#pragma mark - Not Changed

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




@end
